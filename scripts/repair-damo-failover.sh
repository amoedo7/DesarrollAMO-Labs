#!/usr/bin/env bash
set -u

# DAMO emergency failover repair for OpenClaw.
# Safe properties:
# - never changes the configured primary model
# - creates a timestamped backup before writes
# - only installs fallbacks that pass a live smoke probe
# - leaves existing fallback config untouched if no healthy alternative is found
# - does not print API keys or secret values

STAMP="$(date +%Y%m%d-%H%M%S)"
STATE_DIR="${OPENCLAW_STATE_DIR:-$HOME/.openclaw}"
BACKUP_DIR="$STATE_DIR/repair-backups/$STAMP"
LOG="$BACKUP_DIR/repair.log"
mkdir -p "$BACKUP_DIR"
exec > >(tee -a "$LOG") 2>&1

echo "=== DAMO FAILOVER REPAIR $STAMP ==="

if ! command -v openclaw >/dev/null 2>&1; then
  echo "ERROR: openclaw no está en PATH. No se modificó nada."
  exit 20
fi

OPENCLAW_BIN="$(command -v openclaw)"
echo "openclaw: $OPENCLAW_BIN"
openclaw --version || true

# Backup only state/config surfaces this repair may cause OpenClaw to rewrite.
if [ -f "$STATE_DIR/openclaw.json" ]; then
  cp -a "$STATE_DIR/openclaw.json" "$BACKUP_DIR/openclaw.json.before"
fi
find "$STATE_DIR/agents" -type f \( -name 'models.json' -o -name 'auth*.json' -o -name 'auth*.sqlite*' \) -print0 2>/dev/null \
  | while IFS= read -r -d '' f; do
      rel="${f#$STATE_DIR/}"
      mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
      cp -a "$f" "$BACKUP_DIR/$rel" 2>/dev/null || true
    done

echo "backup: $BACKUP_DIR"

echo
echo "--- gateway before ---"
openclaw gateway status --deep --json || true

echo
echo "--- config/model before ---"
openclaw config get agents.defaults.model --json || true
openclaw models fallbacks list --plain || true

# Read-only lint first; repair only if lint reports a problem.
echo
echo "--- doctor lint ---"
if ! openclaw doctor --lint --json; then
  echo "Doctor encontró drift/config dañada; aplicando reparación recomendada..."
  openclaw doctor --fix --non-interactive || true
fi

MODEL_LIST="$BACKUP_DIR/models.list"
openclaw models list --plain 2>/dev/null \
  | awk '{print $1}' \
  | grep -E '^[A-Za-z0-9_.-]+/.+' \
  | awk '!seen[$0]++' > "$MODEL_LIST" || true

if [ ! -s "$MODEL_LIST" ]; then
  echo "ERROR: OpenClaw no reporta modelos configurados/visibles. No se tocó la cadena de fallback."
  exit 21
fi

CURRENT_FALLBACKS="$BACKUP_DIR/fallbacks.before"
openclaw models fallbacks list --plain 2>/dev/null \
  | awk '{print $1}' \
  | grep -E '^[A-Za-z0-9_.-]+/.+' \
  | awk '!seen[$0]++' > "$CURRENT_FALLBACKS" || true

PRIMARY="$(python3 - <<'PY' 2>/dev/null || true
import json, subprocess
for path in ('agents.defaults.model.primary','agents.defaults.model'):
    try:
        p=subprocess.run(['openclaw','config','get',path,'--json'],text=True,capture_output=True,timeout=10)
        if p.returncode:
            continue
        v=json.loads(p.stdout)
        if isinstance(v,str) and '/' in v:
            print(v); break
        if isinstance(v,dict) and isinstance(v.get('primary'),str):
            print(v['primary']); break
    except Exception:
        pass
PY
)"
echo "primary preservado: ${PRIMARY:-desconocido}"

probe_model() {
  local model="$1"
  local out="$BACKUP_DIR/probe-$(echo "$model" | tr '/:' '__').json"
  echo -n "probe $model ... "

  if openclaw infer model run --help >/dev/null 2>&1; then
    if timeout 45s openclaw infer model run --local --model "$model" \
        --prompt "Reply with exactly: DAMO_PROBE_OK" --json >"$out" 2>&1; then
      echo "OK"
      return 0
    fi
  elif openclaw agent exec --help >/dev/null 2>&1; then
    if timeout 60s openclaw agent exec "Reply with exactly: DAMO_PROBE_OK" \
        --model "$model" --timeout 35 --json >"$out" 2>&1; then
      echo "OK"
      return 0
    fi
  else
    echo "SKIP (esta versión no tiene probe headless conocido)"
    return 2
  fi

  # Do not echo provider payloads here; they can include verbose diagnostics.
  echo "FAIL"
  return 1
}

HEALTHY="$BACKUP_DIR/healthy-fallbacks"
: > "$HEALTHY"
add_healthy() {
  local m="$1"
  [ -n "$m" ] || return 0
  [ "$m" = "$PRIMARY" ] && return 0
  grep -Fxq "$m" "$HEALTHY" 2>/dev/null && return 0
  if probe_model "$m"; then
    echo "$m" >> "$HEALTHY"
  fi
}

# 1) Keep any existing fallback that is actually alive now (max 8 probes).
count=0
while IFS= read -r m; do
  [ -n "$m" ] || continue
  add_healthy "$m"
  count=$((count+1))
  [ "$count" -ge 8 ] && break
done < "$CURRENT_FALLBACKS"

# 2) Discover one live model per already-configured alternate provider.
# Order favors generally capable hosted providers; local Ollama is the final safety net.
for provider in google groq mistral minimax zai z-ai openrouter cerebras ollama; do
  tried=0
  while IFS= read -r m; do
    [ -n "$m" ] || continue
    [ "$m" = "$PRIMARY" ] && continue
    grep -Fxq "$m" "$HEALTHY" 2>/dev/null && continue
    add_healthy "$m"
    tried=$((tried+1))
    # At most two tiny probes per provider to keep repair cheap.
    [ "$tried" -ge 2 ] && break
  done < <(grep -E "^${provider}/" "$MODEL_LIST" 2>/dev/null || true)
done

if [ ! -s "$HEALTHY" ]; then
  echo
  echo "ERROR: no encontré ningún fallback que responda ahora."
  echo "Conservo la configuración anterior intacta. Revisá auth/créditos o conectá un proveedor/local Ollama."
  exit 22
fi

echo
echo "--- healthy fallbacks ---"
cat "$HEALTHY"

# Replace only the fallback array, because every entry below passed a live probe.
# Primary remains untouched.
echo
echo "Instalando cadena limpia de fallback..."
openclaw models fallbacks clear
while IFS= read -r m; do
  [ -n "$m" ] || continue
  openclaw models fallbacks add "$m"
done < "$HEALTHY"

echo
echo "--- fallbacks after ---"
openclaw models fallbacks list --plain || true

# Restart through the supported gateway lifecycle. Do not stop/start manually.
echo
echo "--- restart gateway ---"
if ! openclaw gateway restart --safe; then
  openclaw gateway restart --wait 30s || true
fi
sleep 2
openclaw gateway status --deep --json || true

# End-to-end smoke test through DAMO's main agent; fallback chain is allowed
# because we do not pin a model on this turn.
echo
echo "--- DAMO end-to-end smoke test ---"
if timeout 90s openclaw agent --agent main --message "Responde exactamente: DAMO_OK" --timeout 60 --json \
    > "$BACKUP_DIR/damo-smoke.json" 2>&1; then
  echo "DAMO_OK: gateway + agent + fallback responden."
  echo "REPAIR_STATUS=PASS"
  exit 0
fi

echo "El gateway está reparado y hay fallbacks vivos, pero el smoke del agente main falló."
echo "Posible causa: la conversación actual quedó fijada a un modelo de usuario agotado."
echo "En el chat con DAMO enviá como comando aislado: /model default"
echo "Después: /reset soft"
echo "REPAIR_STATUS=PARTIAL"
exit 10
