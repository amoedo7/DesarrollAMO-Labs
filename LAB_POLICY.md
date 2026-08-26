# Política del laboratorio

DesarrollAMO-Labs es el sandbox del ecosistema. **Prueba no significa producción.**

## Permitido

- experimentos incompletos;
- prototipos de nuevas capabilities;
- comparaciones y benchmarks;
- candidatos de apps y packages;
- pruebas destructivas que no afecten recursos reales.

## Prohibido

- secretos, tokens, claves privadas o `.env` reales;
- credenciales de producción;
- publicar directamente en StoreAMO como `verified`;
- escribir en `main` de RaízAMO desde un experimento;
- depender de datos reales sensibles para que una demo funcione;
- afirmar que un candidato está integrado sin pasar promoción.

## Promoción

```text
experiment
→ reproducible
→ candidate
→ PR hacia fuente oficial
→ CI
→ seguridad
→ build/artefacto
→ verificación StoreAMO
→ integrated/verified
```

Un agente Constructor puede trabajar libremente dentro de estos límites, pero no puede aprobar su propia promoción.
