# SIGIT-Funda-Salud
# Sistema de Gestión de Informes Técnicos - FUNDASALUD
<p>Lógica de Negocios</p>

> ### 1. Propósito del Sistema
El sistema tiene como objetivo **automatizar, centralizar y optimizar** la elaboración, revisión, aprobación, control y almacenamiento de los informes técnicos del Departamento de Informática de la Fundación Trujillana de la Salud (FUNDASALUD).

>### 2. Reglas de Negocio Generales

**RN-01 – Creación de Informes**  
Todo informe técnico debe ser registrado en el sistema por un usuario con rol de **Técnico** o superior. Cada informe debe contener obligatoriamente: título, descripción, fecha, técnico responsable y al menos un archivo adjunto como evidencia.

**RN-02 – Estados del Ciclo de Vida del Informe**
- **Borrador**: En elaboración.
- **En Revisión**: Enviado para supervisión.
- **Aprobado**: Revisado y aprobado por el supervisor o jefe de departamento.
- **Rechazado**: Devuelto con observaciones para corrección.
- **Archivado**: Informe finalizado y almacenado de forma definitiva.

**RN-03 – Flujo de Aprobación**  
El informe sigue un flujo secuencial:  
Técnico → Crea (Borrador) → Envía a Revisión → Supervisor revisa → Aprueba o Rechaza → (Si es aprobado) se archiva automáticamente.

**RN-04 – Control de Acceso y Permisos**  
- **Técnico**: Puede crear, editar y consultar solo sus propios informes.  
- **Supervisor**: Puede revisar, aprobar/rechazar y consultar todos los informes de su departamento.  
- **Administrador**: Acceso total al sistema (gestión de usuarios, reportes y configuración).

**RN-05 – Restricciones de Validación**
- No se permite duplicidad de número de informe dentro del mismo año.  
- La fecha del informe no puede ser posterior a la fecha actual.  
- Los informes en estado **Aprobado** o **Archivado** no podrán ser editados ni eliminados.  
- Todo informe debe registrar el historial de cambios (auditoría).

**RN-06 – Gestión de Usuarios** 

El sistema debe manejar roles y permisos basados en la estructura organizacional del Departamento de Informática.

**RN-07 – Seguridad de la Información**
- Todos los usuarios deben autenticarse para acceder al sistema.  
- Se debe registrar el usuario, fecha y hora de cada operación crítica.  
- Los informes aprobados deben tener respaldo automático.

>### 3. Objetivos de la Lógica de Negocios

- Eliminar por completo la elaboración manual de informes en formato físico.
- Reducir significativamente los tiempos de elaboración, revisión y búsqueda de información.
- Garantizar la **integridad, trazabilidad y confidencialidad** de los informes técnicos.
- Mejorar el control y seguimiento de las actividades realizadas por el Departamento de Informática.
- Facilitar la generación de reportes gerenciales y estadísticos.

