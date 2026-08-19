# Cola de producción DesarrollAMO

Regla: una ejecución trabaja UNA app. Si existe un repo con el nombre de la app, usarlo. Si no existe o no conviene crear uno separado, usar este monorepo bajo `apps/<NombreApp>/` manteniendo identidad, versión, tests, build y manifiesto StoreAMO propios.

Objetivo de cada app: primera versión funcional v0.1.0, estado candidate, build reproducible, artefacto verificable e integración en StoreAMO.

## Cola

1. RelojAMO
2. CalculAMO
3. CronAMO
4. TemporizAMO
5. NotasAMO
6. TareasAMO
7. ConversAMO
8. PorcentAMO
9. ContAMO
10. DadosAMO
11. SorteAMO
12. HabitAMO
13. AlarmAMO
14. CalendAMO
15. LinternAMO
16. BrujulAMO
17. NivelAMO
18. GastAMO
19. ContrasenAMO
20. QRAMOMini
21. ColorAMO
22. ReglaAMO
23. EdadAMO
24. FechaAMO
25. PropinAMO
26. DivisAMO
27. TextoAMO
28. PalabrAMO
29. ListAMO
30. RecordAMO
31. ContactAMO
32. MarcadorAMO
33. FavoritAMO
34. PortapapelAMO
35. ArchivAMO
36. HashAMO
37. Base64AMO
38. UUIDAMO
39. JSONAMO
40. RegexAMO
41. IPAMO
42. RedLocalAMO
43. WifiAMO
44. SensorAMO
45. BateriAMO
46. EspacioAMO
47. DispositivAMO
48. ChecklistAMO
49. DiarioAMO
50. FrasesAMO

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
