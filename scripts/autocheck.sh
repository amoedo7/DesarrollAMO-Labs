#!/usr/bin/env bash
set -euo pipefail

python - <<'PY'
import json
from pathlib import Path

path = Path('.amo')
data = json.loads(path.read_text(encoding='utf-8'))
assert data['schema'] == 'desarrollamo.amo.v1'
assert data['id'] == 'desarrollamo-labs'
checks = data.get('health', {}).get('checks', [])
assert any(check.get('command') == 'bash scripts/autocheck.sh' for check in checks)
assert data.get('policy', {}).get('self_declared_pass_allowed') is False
print('CONTRACT_OK DesarrollAMO-Labs')
PY

python scripts/validate_lab.py
