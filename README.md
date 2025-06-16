# Mireon Roleplay GM

![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)
![Incompleto](https://img.shields.io/badge/estado-incompleto-lightgrey)
![Abandonado](https://img.shields.io/badge/estado-abandonado-darkred)
![Hecho con ❤️ por Mireon RP](https://img.shields.io/badge/made%20with-%E2%9D%A4-red)

Gamemode (GM) modular y extensible para servidores Multi Theft Auto: San Andreas (MTA:SA), desarrollado para el servidor **Mireon RP**. Incluye sistemas integrales para administración, economía, interacción civil, IC/OOC, combate, control vehicular, y más.

---

## 📦 Módulos principales

### 🔧 Núcleo
- **MR1_Inicio**: Conexión MySQL, sistema de reinicio diario, textos 3D, top diario e histórico de jugadores.
- **MR2_Cuentas**: Registro, login, creación de personajes, DNI, integración con DB.
- **MR3_Muertes**: Headshot, muerte persistente, reaparecer en hospital, soporte a comandos staff.
- **MR4_Chats**: Chats IC/OOC, radio con frecuencias, MP, y sistema de staff.
- **MR5_Interiores**: Entradas/salidas con base de datos, pickups, teletransportes dinámicos.

### 💰 Economía y recursos
- **MR6_Economia**: Sistema bancario, ATMs, comandos para transferencias.
- **MR7_Vehiculos**: Vehículos propios, bloqueo, motor, maletero, compraventa.
- **MR8_Licencieros**: Sistema de examen y compra de licencias (coche, moto, camión).
- **MR9_Concesionarios**: Compra de vehículos desde UI conectada a DB.
- **MR17_Casas**: Sistema de propiedades persistentes, compra y gestión de casas.
- **MR18_247**: Tiendas 24/7 con sistema de compra y objetos varios.

### 🎮 Experiencia del jugador
- **MR11_Skins**: Tiendas de ropa con skins categorizados por género y tienda.
- **MR13_Comandos**: Ajustes gráficos, acceso a video tutorial, stats de cuenta.
- **MR14_HUD**: HUD y radar personalizado, sistema de estamina, reloj, necesidades básicas.

### 🛡️ Moderación y administración
- **MR12_Moderacion**: Jail visual, dudas, reportes, staff tools, sistema de rangos.
- **MR15_Discord**: Webhooks con logs de conexión, sanciones, economía, y más.

### 🔫 Armamento
- **MR16_Armas** *(basado en Clawsuit)*: Tiendas, comandos IC para recoger/dar/tirar armas, integraciones con DB y Discord.

---

## ⚙️ Requisitos del servidor
- MTA:SA Server
- MySQL (MariaDB compatible)
- [mta_mysql](https://community.multitheftauto.com/index.php?p=resources&s=details&id=236) o sistema equivalente

---

## 🗃️ Base de datos

Incluye un archivo `.sql` para importar directamente todas las tablas necesarias al servidor MySQL. Asegúrate de configurar correctamente el acceso en `MR1_Inicio/db_config.xml`.

---

## 🤝 Contribuciones

Este proyecto es **público y abierto a mejoras**. Para colaborar:

- Haz fork del repositorio
- Crea una rama con tu cambio
- Envia un Pull Request

Todas las ideas serán evaluadas por el desarrollador.

---

## 👤 Créditos

- GM desarrollada por: [ElTitoJet](https://github.com/ElTitoJet)
- Inspirado y extendido desde scripts de: [Clawsuit](https://github.com/clawsuit)
- Comunidad Mireon RP

---

## 📄 Licencia

Este proyecto está licenciado bajo **MIT**. Consulta `LICENSE` para más detalles.
