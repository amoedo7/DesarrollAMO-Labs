# Cola de producción DesarrollAMO

Regla: una ejecución trabaja UNA app. Si existe un repo con el nombre de la app, usarlo. Si no existe o no conviene crear uno separado, usar este monorepo bajo `apps/<NombreApp>/` manteniendo identidad, versión, tests, build y manifiesto StoreAMO propios.

Objetivo de cada app: primera versión funcional v0.1.0, estado candidate, build reproducible, artefacto verificable e integración en StoreAMO.

## Cola

1. [x] RelojAMO — v0.1.0 candidate; CI verde; APK + SHA-256 verificados; PR #1 fusionado. StoreAMO pendiente del soporte de descubrimiento de repos privados (StoreAMO-Catalog #2).
2. [x] CalculAMO — v0.1.0 candidate; CI Android #6 verde; APK + SHA-256 verificados (`021eb4dcd8cf845d89d0153eba1eb08fe4f399a9c9cf31676b13301931bb39ef`); PR #1 fusionado (`c095da67a33af09445df0943430de631bfbd967a`). Workflow de main publica GitHub Release v0.1.0; StoreAMO pendiente del soporte de descubrimiento de repos privados (StoreAMO-Catalog #2).
3. [x] CronAMO — v0.1.0 candidate; CI Android #7 verde; 4 tests; APK real + SHA-256 verificados (`9dd9dcb91e394ebcb5135297b2eb7bd03e9e591f84428e028394e00a29cb2253`); PR #1 fusionado (`a8ee34b605d988136ba02a2f727aa3b7da9d649c`). Workflow de main publica GitHub Release v0.1.0; StoreAMO pendiente del soporte de descubrimiento de repos privados (StoreAMO-Catalog #2).
4. [x] TemporizAMO — v0.1.0 candidate; CI Android #7 verde; 4 tests; APK real + SHA-256 verificados (`0582286941d47f9cea1e4e6c527ac9214e60ad3558b349ac8d3fad93b84e159d`); PR #1 fusionado (`73eb9c6a340d18ae6e626edc018399c12824e739`). Workflow de main publica GitHub Release v0.1.0; StoreAMO pendiente del soporte de descubrimiento de repos privados (StoreAMO-Catalog #2).
5. [x] NotasAMO — v0.1.0 candidate; CI Android #1 verde; 4 tests; APK real + SHA-256 verificados (`5c195e8c74f37b648a8245bb373fb0562112f93986e0d2afe36eceb3f03b381f`); PR #1 fusionado (`7e1359f7b1b054a612e6a71e4090c4a20e0958f9`). Workflow de main publica GitHub Release v0.1.0; StoreAMO pendiente del soporte de descubrimiento de repos privados (StoreAMO-Catalog #2).
6. [ ] TareasAMO
7. [x] ConversAMO — v0.1.0 candidate; CI Android #6 verde; 4 tests; APK real + SHA-256 verificados (`f339cd2c624c7d4c39998fad170606452be4cd60ea55b1821e35cd037ff3ad82`); PR #1 fusionado (`5f6d17d23f3ab1117b5573977190d7c7edcd3d6e`). Workflow de main publica GitHub Release v0.1.0; StoreAMO pendiente del soporte de descubrimiento de repos privados (StoreAMO-Catalog #2).
8. [x] PorcentAMO — v0.1.0 candidate; CI Android #5 verde; 4 tests JUnit; APK real + SHA-256 verificados (`2fc11603cd3ecfe396169d06c3e6462d8de6af800fd7428aeb5c2615796c8fa7`); PR #2 fusionado (`05e85c92674a1ee626dcacd1f7a15522c4322bef`). Workflow de main publica GitHub Release v0.1.0; StoreAMO pendiente del soporte de descubrimiento de repos privados (StoreAMO-Catalog #2).
9. [ ] ContAMO
10. [ ] DadosAMO
11. [ ] SorteAMO
12. [ ] HabitAMO
13. [ ] AlarmAMO
14. [ ] CalendAMO
15. [ ] LinternAMO
16. [ ] BrujulAMO
17. [ ] NivelAMO
18. [ ] GastAMO
19. [ ] ContrasenAMO
20. [ ] QRAMOMini
21. [x] ColorAMO — v0.1.0 candidate en `apps/ColorAMO/`; 5 tests JUnit; Android CI verde; APK real + SHA-256 verificados (`85c114f3041a33a5081ab029a137518f2bbc15a36dda0be5e98c0ac3c8c1da16`); PR #2 fusionado (`947ee2bb4fe03ea2315e9e02626c7076f33e1b40`). Workflow de main publica release `coloramo-v0.1.0`; StoreAMO bloqueado por discovery de manifiestos anidados/privados.
22. [ ] ReglaAMO
23. [ ] EdadAMO
24. [ ] FechaAMO
25. [ ] PropinAMO
26. [ ] DivisAMO
27. [ ] TextoAMO
28. [ ] PalabrAMO
29. [ ] ListAMO
30. [ ] RecordAMO
31. [ ] ContactAMO
32. [ ] MarcadorAMO
33. [ ] FavoritAMO
34. [ ] PortapapelAMO
35. [ ] ArchivAMO
36. [ ] HashAMO
37. [ ] Base64AMO
38. [ ] UUIDAMO
39. [ ] JSONAMO
40. [ ] RegexAMO
41. [ ] IPAMO
42. [ ] RedLocalAMO
43. [ ] WifiAMO
44. [ ] SensorAMO
45. [ ] BateriAMO
46. [ ] EspacioAMO
47. [ ] DispositivAMO
48. [ ] ChecklistAMO
49. [ ] DiarioAMO
50. [ ] FrasesAMO

## Regla anti-colisión

Antes de modificar una app, revisar ramas/PRs/trabajo activo. No pisar una ejecución en curso. Elegir la primera app pendiente que no tenga trabajo activo.

## Definición de terminado v0.1.0

- funcionalidad principal real;
- tests razonables;
- build verde comprobado;
- versión 0.1.0;
- `amo.project.json` cuando corresponda;
- manifiesto StoreAMO;
- release/artefacto cuando la plataforma lo permita;
- integridad SHA-256;
- estado `candidate`, nunca `verified` sin evidencia;
- visible en StoreAMO o bloqueo documentado con evidencia.
