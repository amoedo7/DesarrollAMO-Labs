<div align="center">
  <img src="https://raw.githubusercontent.com/amoedo7/landings/main/assets/github/labs.svg" width="100%" alt="DesarrollAMO Labs" />

# DesarrollAMO Labs

**Prueba, no promesa.**

Pequeñas herramientas, experimentos y piezas ejecutables que muestran cómo resolvemos problemas.
</div>

---

## Suite `Mi...`

Estas herramientas tienen repositorio propio porque representan capacidades reutilizables de DesarrollAMO.

| Proyecto | Pregunta que responde | Plataformas |
|---|---|---|
| [`MiDispositivo`](https://github.com/amoedo7/MiDispositivo) | ¿Qué equipo tengo delante? | Android/Termux · Windows · macOS · Linux |
| [`MiRed`](https://github.com/amoedo7/MiRed) | ¿Cómo está conectándose? | Android/Termux · Windows · macOS · Linux |
| [`MiSistema`](https://github.com/amoedo7/MiSistema) | ¿Qué puede ejecutar? | Android/Termux · Windows · macOS · Linux |
| [`MiWeb`](https://github.com/amoedo7/MiWeb) | ¿Cómo está esta web? | Python 3 / cualquier plataforma |
| [`MiArchivos`](https://github.com/amoedo7/MiArchivos) | ¿Qué ocupa y cómo está organizado? | Android/Termux · Windows · macOS · Linux |
| [`MiAPI`](https://github.com/amoedo7/MiAPI) | ¿Cómo responde este endpoint? | Python 3 / cualquier plataforma |
| [`DiagnosticoAMO`](https://github.com/amoedo7/DiagnosticoAMO) | ¿Qué significa todo junto? | procesamiento local de reportes JSON |

---

## Demos pequeñas

Las piezas que todavía no necesitan un producto/repo propio viven como Labs. El catálogo histórico de demos sigue disponible en [`landings/demos`](https://github.com/amoedo7/landings/tree/main/demos) mientras migramos únicamente lo que merece conservarse.

Actualmente hay demostraciones funcionales de:

- chequeo de URL con contrato común Bash / PowerShell / Python;
- integridad SHA-256 multiplataforma;
- Browser Data Toolbox para JSON, SHA-256, Base64 y URLs;
- visualización local de reportes técnicos.

## Regla de entrada

Un experimento entra a Labs cuando cumple:

```text
problema concreto
      ↓
implementación pequeña
      ↓
resultado observable
      ↓
forma reproducible de probarlo
```

No buscamos llenar GitHub de repos vacíos. Una pieza nueva debe demostrar algo que funcione, tener una explicación clara y no requerir secretos para probarse.

## Contratos de la suite

```text
desarrollamo.midispositivo.v1
desarrollamo.mired.v1
desarrollamo.misistema.v1
desarrollamo.miweb.v1
desarrollamo.miarchivos.v1
desarrollamo.miapi.v1
desarrollamo.diagnostico.v1
```

La idea es que las herramientas puedan evolucionar de forma independiente pero sus resultados sigan siendo combinables.

---

<div align="center">

**DesarrollAMO** · Software · automatización · sistemas

[Perfil](https://github.com/amoedo7) · [Web](https://desarrollamo.com.ar/)

</div>
