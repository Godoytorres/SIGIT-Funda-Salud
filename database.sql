-- Generado por Tecnopraxis — Diseñador de BD

CREATE TABLE `usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `cedula` VARCHAR(20) NOT NULL,
  `email` VARCHAR(120) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `telefono` VARCHAR(20),
  `cargo` VARCHAR(80) NOT NULL,
  `rol` VARCHAR('admin', 'tecnico', 'supervisor', 'usuario') DEFAULT 'tecnico',
  `estado` VARCHAR('activo', 'inactivo', 'suspendido') DEFAULT 'activo',
  `foto_perfil` VARCHAR(255),
  `fecha_registro` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `ultimo_acceso` TIMESTAMP,
  `verificado` BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `uq_usuarios_cedula` (`cedula`),
  UNIQUE KEY `uq_usuarios_email` (`email`)
);

CREATE TABLE `informes_tecnicos` (
  `id_informe` INT NOT NULL AUTO_INCREMENT,
  `codigo_informe` VARCHAR(50) NOT NULL,
  `titulo` VARCHAR(200) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `tipo_informe` VARCHAR('Soporte Técnico', 'Mantenimiento', 'Instalación', 
                       'Actualización', 'Diagnóstico', 'Otro') NOT NULL,
  `prioridad` VARCHAR('Baja', 'Media', 'Alta', 'Crítica') DEFAULT 'Media',
  `estado` VARCHAR('Borrador', 'En Revisión', 'Aprobado', 'Rechazado', 
                'En Ejecución', 'Finalizado', 'Archivado') DEFAULT 'Borrador',
  `id_usuario_creador` INT NOT NULL,
  `id_usuario_asignado` INT,
  `id_usuario_revisor` INT,
  `fecha_creacion` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `fecha_asignacion` TIMESTAMP,
  `fecha_inicio` TIMESTAMP,
  `fecha_fin` TIMESTAMP,
  `fecha_revision` TIMESTAMP,
  `observaciones` TEXT,
  `archivo_adjunto` VARCHAR(255),
  `equipo_afectado` VARCHAR(150),
  PRIMARY KEY (`id_informe`),
  UNIQUE KEY `uq_informes_tecnicos_codigo_informe` (`codigo_informe`)
);

CREATE TABLE `categorias_informe` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(255),
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `uq_categorias_informe_nombre` (`nombre`)
);

CREATE TABLE `informe_categoria` (
  `id_informe` INT NOT NULL,
  `id_categoria` INT NOT NULL,
  PRIMARY KEY (`id_informe`, `id_categoria`)
);

CREATE TABLE `historial_informe` (
  `id_historial` INT NOT NULL AUTO_INCREMENT,
  `id_informe` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `accion` VARCHAR(100) NOT NULL,
  `descripcion` TEXT,
  `fecha` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_historial`)
);

CREATE TABLE `sesiones` (
  `id_sesion` INT NOT NULL AUTO_INCREMENT,
  `id_usuario` INT NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `ip_address` VARCHAR(45),
  `user_agent` TEXT,
  `fecha_inicio` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `fecha_expiracion` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id_sesion`),
  UNIQUE KEY `uq_sesiones_token` (`token`)
);

ALTER TABLE `informes_tecnicos` ADD CONSTRAINT `fk_rel_57` FOREIGN KEY (`id_usuario_creador`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE `informes_tecnicos` ADD CONSTRAINT `fk_rel_58` FOREIGN KEY (`id_usuario_asignado`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE `informes_tecnicos` ADD CONSTRAINT `fk_rel_59` FOREIGN KEY (`id_usuario_revisor`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE `informe_categoria` ADD CONSTRAINT `fk_rel_60` FOREIGN KEY (`id_informe`) REFERENCES `informes_tecnicos` (`id_informe`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `informe_categoria` ADD CONSTRAINT `fk_rel_61` FOREIGN KEY (`id_categoria`) REFERENCES `categorias_informe` (`id_categoria`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `historial_informe` ADD CONSTRAINT `fk_rel_62` FOREIGN KEY (`id_informe`) REFERENCES `informes_tecnicos` (`id_informe`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `historial_informe` ADD CONSTRAINT `fk_rel_63` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE `sesiones` ADD CONSTRAINT `fk_rel_64` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;