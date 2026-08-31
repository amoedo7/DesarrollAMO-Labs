# DesarrollAMO-Labs Recovery

Este procedimiento recupera el estado versionado de **DesarrollAMO-Labs** sin promover experimentos ni ampliar la autoridad del sandbox.

## Fuente de verdad

La fuente recuperable es el repositorio `amoedo7/DesarrollAMO-Labs` y su historial Git. Los directorios `experiments/`, `candidates/` y `quarantine/` siguen siendo material de laboratorio: restaurarlos no los convierte en producto, release ni artefacto aprobado.

## Recuperación segura

1. Identificar el último commit conocido como sano mediante historial y CI.
2. Crear una rama de recuperación desde ese commit; no reescribir `main` ni usar force-push.
3. Restaurar únicamente archivos versionados necesarios para reproducir el estado conocido.
4. No restaurar ni introducir `.env`, claves privadas, tokens, secretos o material externo no versionado.
5. Ejecutar `bash scripts/autocheck.sh` y cualquier gate adicional afectado.
6. Si el check falla o no puede ejecutarse, registrar el resultado como `UNKNOWN`/bloqueado y no promover el cambio.
7. Integrar por PR sólo después de evidencia PASS proporcional al cambio.

## Rollback

Si una recuperación integrada causa regresión, revertir el commit/PR que la introdujo y volver a ejecutar el AutoCheck. No borrar evidencia histórica ni reescribir commits publicados.

## Fronteras

- Recuperar Labs no autoriza cambios en CircuitAMO, StoreAMO ni otras unidades.
- Ningún candidato queda verificado o publicable por el solo hecho de ser restaurado.
- La promoción fuera de Labs conserva los contratos y gates de la unidad de destino.
- Una ejecución CI verde no prueba instalación física ni estado de producción externo.
