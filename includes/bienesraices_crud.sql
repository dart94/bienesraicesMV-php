/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE `propiedades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `imagen` varchar(200) DEFAULT NULL,
  `descripcion` longtext,
  `habitacion` int DEFAULT NULL,
  `wc` int DEFAULT NULL,
  `estacionamiento` int DEFAULT NULL,
  `creado` date DEFAULT NULL,
  `vendedores_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_propiedades_vendedores_idx` (`vendedores_id`),
  CONSTRAINT `fk_propiedades_vendedores` FOREIGN KEY (`vendedores_id`) REFERENCES `vendedores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) DEFAULT NULL,
  `password` char(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;

CREATE TABLE `vendedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

INSERT INTO `propiedades` (`id`, `titulo`, `precio`, `imagen`, `descripcion`, `habitacion`, `wc`, `estacionamiento`, `creado`, `vendedores_id`) VALUES
(46, 'Casa Diego', '15974411.00', 'f52f9410610b6bbb19247f55ad29c8ba.jpg', 'Casa Diego en la plaaya', 3, 2, 1, '2024-04-18', 1);
INSERT INTO `propiedades` (`id`, `titulo`, `precio`, `imagen`, `descripcion`, `habitacion`, `wc`, `estacionamiento`, `creado`, `vendedores_id`) VALUES
(47, 'Casa en renta', '5000450.00', '61aa62f21b81756496c5ed5b05502b13.jpg', 'Casa en renta, excelente ubicación', 4, 2, 2, '2024-04-18', 1);
INSERT INTO `propiedades` (`id`, `titulo`, `precio`, `imagen`, `descripcion`, `habitacion`, `wc`, `estacionamiento`, `creado`, `vendedores_id`) VALUES
(54, ' crear', '1512314.00', '5d4afdb504ca3831f3be4690e8ce03d1.jpg', 'Casa Casa Casa Casa Casa Casa Casa Casa ', 1, 2, 1, '2024-09-30', 1);
INSERT INTO `propiedades` (`id`, `titulo`, `precio`, `imagen`, `descripcion`, `habitacion`, `wc`, `estacionamiento`, `creado`, `vendedores_id`) VALUES
(60, ' Casa en la playa en OFERTAA', '41111.00', 'e761c66220dbefb3aa32a2e78319f290.jpg', 'casa cas casa cas casa cas casa cas casa cas casa cas casa cas casa casa', 3, 2, 1, '2024-10-08', 1),
(61, ' casa diego desdde mvc', '14852351.00', 'ea80f22946028353896ac1237ee774b5.jpg', ' Casa Diego  Casa Diego  Casa Diego  Casa Diego  Casa Diego  Casa Diego  Casa Diego  Casa Diego  ', 3, 2, 1, '2024-10-24', 1),
(62, ' Casa en la playa en oferta', '200820.00', '9f3d2c2743ae500c691c1db126621d7c.jpg', 'Casa Diego  Casa Diego  Casa Diego  Casa Diego  Casa Diego  Casa Diego  Casa Diego  Casa Diego  ', 3, 2, 1, '2024-10-24', 1);

INSERT INTO `usuarios` (`id`, `email`, `password`) VALUES
(3, 'correo@correo.com', '$2y$10$qnEW6Jguvzg/mwhHvfmQ.e9k/hq43nuKnT.s8hT7YFLo9QBe9U7JW');
INSERT INTO `usuarios` (`id`, `email`, `password`) VALUES
(4, 'correo@correo.com', '$2y$10$J0ymO9eFeVjq/tElftfxkOvb/TT121mFYQg1YGitR2dyZCNlMNRQ6');
INSERT INTO `usuarios` (`id`, `email`, `password`) VALUES
(5, 'correo@correo.com', '$2y$10$rFkRO3bmqHsGfAYXV54rEuCt2xsGTKSw1bvlya/urWCehcQqrBqd.');
INSERT INTO `usuarios` (`id`, `email`, `password`) VALUES
(6, 'correo@correo.com', '$2y$10$pei15M/MrDfCx6cmwrUkx.8GNWx.uiizYF4vbuE/GRYinkv82r2eW'),
(7, 'correo@correo.com', '$2y$10$vHlIJXP343g92E.xxGcHWuwogRzwTPMPDTIDbV.xVZLWsuSl28qzG'),
(8, 'correo@correo.com', '$2y$10$0YjU9gSVSYoZbCLTAHwGUu1RrogzFk2hJmuMwnkFiHv7/OEFf/156'),
(9, 'correo@correo.com', '$2y$10$7utlAaYuOyrczIgoA.45auJGVBqjQxMkNQupluV5u2RRsBMle5r8G'),
(10, 'correo@correo.com', '$2y$10$8PcfehSHJAb5bMq05A6iuer8/jQqhRSHPAHM6gcwitHz0IHYzXubu'),
(11, 'correo@correo.com', '$2y$10$cV1vKtTVdoYeOjEMcd1Rxedoi/747wFe0szhv0Vj5IbBfRmwykh5m'),
(12, 'correo@correo.com', '$2y$10$itj70hoc7JMjiqLFmB98KuBvzMXIA69h/NQ61tDlbIvhpmdIs/bqS'),
(13, 'correo@correo.com', '$2y$10$ucZY5iiurtnKQqpjTDNS6O9/aCinnTFDcy3CFSEp4yxU6dxu5CPGi'),
(14, 'correo@correo.com', '$2y$10$jt6kLcaOAWanpfPlshdNvuwEAk1hDQH5jxx1JfhfsakZXDwJ8qID6');

INSERT INTO `vendedores` (`id`, `nombre`, `apellido`, `telefono`) VALUES
(1, 'Alberto', 'Rivera', '1234567891');
INSERT INTO `vendedores` (`id`, `nombre`, `apellido`, `telefono`) VALUES
(2, 'Diego', 'Perez', '6623254234');
INSERT INTO `vendedores` (`id`, `nombre`, `apellido`, `telefono`) VALUES
(4, ' Alberto', 'Rivera', '992252421 ');


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;