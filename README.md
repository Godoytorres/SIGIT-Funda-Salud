# SIGIT-FUNDASALUD

## DESARROLLO DE UN SISTEMA PARA LA ELABORACIÓN Y GESTIÓN DE INFORMES TÉCNICOS DEL DEPARTAMENTO DE INFORMÁTICA DE FUNDASALUD
Sistema de Gestión de Informes Técnicos para el Departamento de Informática de la Fundación Trujillana de la Salud (FUNDASALUD)

>## Descripción General
El presente proyecto consiste en el desarrollo de un sistema que permite **automatizar, centralizar y optimizar** la elaboración, revisión, aprobación, control y almacenamiento de los informes técnicos del Departamento de Informática de FUNDASALUD. 

Actualmente, la elaboración de estos informes se realiza de forma manual y física, lo que genera retrasos, riesgo de pérdida de documentos, duplicidad de información y dificultad para consultar y dar seguimiento a las actividades técnicas. Este sistema busca resolver estas problemáticas mediante la digitalización y estructuración del proceso completo.

>## Objetivo Principal
Automatizar los procesos de elaboración, gestión, control y archivo de los informes técnicos del Departamento de Informática de la Fundación Trujillana de la Salud, con el fin de mejorar la eficiencia, seguridad y trazabilidad de la información técnica institucional.

>## Usuarios Clave (Roles)

- **Técnico**: Encargado de crear, editar y dar seguimiento a sus propios informes técnicos.
- **Supervisor**: Responsable de revisar, solicitar correcciones y aprobar los informes de los técnicos a su cargo.
- **Administrador**: Gestiona usuarios, configura el sistema, genera reportes gerenciales y tiene acceso total a toda la información.

>## Funcionalidades Principales (Alcance)

El sistema permitirá:

- Registrar, editar y gestionar informes técnicos de manera digital.
- Definir y controlar los diferentes estados del informe (Borrador, En Revisión, Aprobado, Rechazado y Archivado).
- Establecer un flujo de aprobación secuencial con notificaciones.
- Asignar técnico responsable y registrar evidencias adjuntas a cada informe.
- Controlar el acceso según roles y permisos de usuario.
- Evitar duplicidad de números de informe por año.
- Mantener un historial completo de cambios y auditoría de cada informe.
- Generar reportes estadísticos y de gestión para los supervisores y directivos.
- Archivar de forma segura los informes una vez aprobados.
- Garantizar la integridad y trazabilidad de toda la información generada.

>## Lógica de Negocios

**RN-01 – Creación de Informes**  
Todo informe debe ser creado por un usuario con rol de Técnico o superior, y debe contener obligatoriamente título, descripción, fecha, técnico responsable y al menos una evidencia adjunta.

**RN-02 – Estados del Ciclo de Vida**  
- Borrador, En Revisión, Aprobado, Rechazado y Archivado.

**RN-03 – Flujo de Aprobación**  
Flujo secuencial: Técnico → Supervisor → Aprobación o Rechazo con observaciones.

**RN-04 – Control de Acceso**  
Acceso restringido según el rol del usuario.

**RN-05 – Reglas de Validación**  
- No se permite duplicidad de número de informe por año.  
- Los informes aprobados no pueden ser editados ni eliminados.  
- Registro obligatorio de auditoría en cada operación.
