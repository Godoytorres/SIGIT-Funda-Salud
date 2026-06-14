# Sistema de Login y Registro

Instrucciones rápidas para ejecutar el proyecto localmente.

Requisitos:
- Node.js (>=14)

Instalación:

```bash
npm install
npm start
```

El servidor quedará en `http://localhost:3000`. La base de datos es un archivo `database.sqlite` en la raíz del proyecto.

Rutas principales:
- `POST /api/register` -> { username, email, password }
- `POST /api/login` -> { email, password }
- `GET /api/user` -> devuelve usuario en sesión
- `POST /api/logout` -> cierra sesión
