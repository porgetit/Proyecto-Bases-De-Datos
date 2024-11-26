-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-11-2024 a las 07:46:34
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `app_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `ID` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`ID`, `nombre`) VALUES
(1, 'Herramientas manuales'),
(2, 'Herramientas eléctricas'),
(3, 'Materiales de construcción'),
(4, 'Pinturas y acabados'),
(5, 'Plomería'),
(6, 'Electricidad'),
(7, 'Jardinería'),
(8, 'Seguridad industrial');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `NID` varchar(20) NOT NULL,
  `primer_nombre` varchar(100) NOT NULL,
  `segundo_nombre` varchar(100) DEFAULT 'Desconocido',
  `primer_apellido` varchar(100) NOT NULL,
  `segundo_apellido` varchar(100) DEFAULT 'Desconocido',
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`NID`, `primer_nombre`, `segundo_nombre`, `primer_apellido`, `segundo_apellido`, `telefono`, `correo`) VALUES
('1122334455', 'Luis', 'Felipe', 'Sánchez', 'Torres', '3009876543', 'luis.sanchez@email.com'),
('1234567890', 'Juan', 'Carlos', 'Pérez', 'Gómez', '3001234567', 'juan.perez@email.com'),
('9876543210', 'Ana', NULL, 'López', 'Martínez', '3007654321', 'ana.lopez@email.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

CREATE TABLE `compras` (
  `ID` int(11) NOT NULL,
  `id_proveedor` varchar(20) NOT NULL,
  `fecha_orden` date NOT NULL,
  `total_pagar` decimal(10,2) NOT NULL,
  `fecha_pago` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`ID`, `id_proveedor`, `fecha_orden`, `total_pagar`, `fecha_pago`) VALUES
(1, '1234567890', '2024-11-10', 500000.00, '2024-11-20'),
(2, '9876543210', '2024-11-12', 100000.00, '2024-11-25'),
(3, '1122334455', '2024-11-15', 150000.00, '2024-11-22');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `inventario`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `inventario` (
`id` int(11)
,`nombre` varchar(100)
,`descripcion` text
,`categoria` varchar(100)
,`precio_compra` decimal(10,2)
,`ganancia` decimal(5,2)
,`stock_actual` int(11)
,`stock_minimo` int(11)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodos_de_pago`
--

CREATE TABLE `metodos_de_pago` (
  `ID` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `metodos_de_pago`
--

INSERT INTO `metodos_de_pago` (`ID`, `nombre`) VALUES
(1, 'Efectivo'),
(2, 'Tarjeta de crédito'),
(3, 'Nequi'),
(4, 'Consignación');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `ID` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `precio_compra` decimal(10,2) NOT NULL,
  `porcentaje_ganancia` decimal(5,2) NOT NULL,
  `cantidad_actual` int(11) NOT NULL,
  `cantidad_minima` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`ID`, `nombre`, `descripcion`, `id_categoria`, `precio_compra`, `porcentaje_ganancia`, `cantidad_actual`, `cantidad_minima`) VALUES
(1, 'Martillo', 'Martillo de acero de 500g', 1, 10.50, 30.00, 100, 10),
(2, 'Destornillador', 'Destornillador de cabeza plana y cruzada', 1, 4.00, 25.00, 150, 15),
(3, 'Taladro eléctrico', 'Taladro con velocidad variable, 600W', 2, 35.00, 40.00, 50, 5),
(4, 'Cemento', 'Cemento de alta resistencia para construcción', 3, 5.00, 20.00, 200, 20),
(5, 'Bloques de concreto', 'Bloques de concreto para construcción', 3, 2.00, 15.00, 500, 50),
(6, 'Pintura acrílica', 'Pintura acrílica de color blanco mate', 4, 8.00, 25.00, 120, 12),
(7, 'Pincel', 'Pincel de 2\" para pintura', 4, 1.50, 20.00, 75, 8),
(8, 'Tubo PVC', 'Tubo PVC para plomería de 2\"', 5, 3.00, 18.00, 150, 15),
(9, 'Cinta aislante', 'Cinta aislante de 10m', 6, 1.00, 15.00, 200, 20),
(10, 'Cable eléctrico', 'Cable eléctrico de 2.5mm para instalaciones', 6, 10.00, 20.00, 80, 8),
(11, 'Tijeras de podar', 'Tijeras de podar de 8\" para jardinería', 7, 12.00, 30.00, 60, 6),
(12, 'Guantes de seguridad', 'Guantes de seguridad para trabajo industrial', 8, 6.00, 25.00, 100, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_compras`
--

CREATE TABLE `productos_compras` (
  `ID` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `id_compra` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos_compras`
--

INSERT INTO `productos_compras` (`ID`, `id_producto`, `id_compra`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `RUT` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono1` varchar(20) NOT NULL,
  `telefono2` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `direccion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`RUT`, `nombre`, `telefono1`, `telefono2`, `correo`, `direccion`) VALUES
('1122334455', 'Proveedor C', '3003214567', NULL, 'proveedorc@email.com', 'Calle Proveedora 3'),
('1234567890', 'Proveedor A', '3001234567', '3009876543', 'proveedora@email.com', 'Calle Proveedora 1'),
('9876543210', 'Proveedor B', '3007654321', '3006549876', 'proveedorb@email.com', 'Calle Proveedora 2');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `proveedores_con_vendedores`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `proveedores_con_vendedores` (
`rut` varchar(20)
,`nombre_proveedor` varchar(100)
,`proveedor_telefono_1` varchar(20)
,`proveedor_telefono_2` varchar(20)
,`proveedor_correo` varchar(100)
,`direccion` text
,`NID` varchar(20)
,`primer_nombre` varchar(100)
,`segundo_nombre` varchar(100)
,`primer_apellido` varchar(100)
,`segundo_apellido` varchar(100)
,`telefono1` varchar(20)
,`telefono2` varchar(20)
,`vendedor_correo` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `registro_venta_productos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `registro_venta_productos` (
`id` int(11)
,`nombre` varchar(100)
,`categoria` varchar(100)
,`precio_compra` decimal(10,2)
,`ganancia` decimal(5,2)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `NID` varchar(20) NOT NULL,
  `primer_nombre` varchar(100) NOT NULL,
  `segundo_nombre` varchar(100) DEFAULT 'Desconocido',
  `primer_apellido` varchar(100) NOT NULL,
  `segundo_apellido` varchar(100) DEFAULT 'Desconocido',
  `telefono1` varchar(20) NOT NULL,
  `telefono2` varchar(20) DEFAULT NULL,
  `correo` varchar(100) NOT NULL,
  `direccion` text DEFAULT NULL,
  `tipo` enum('admin','normal') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`NID`, `primer_nombre`, `segundo_nombre`, `primer_apellido`, `segundo_apellido`, `telefono1`, `telefono2`, `correo`, `direccion`, `tipo`) VALUES
('1122334455', 'Sofia', 'Isabel', 'Martínez', 'Lopez', '3101234321', NULL, 'sofia.martinez@email.com', 'Calle Azul 789', 'normal'),
('1234567890', 'Carlos', 'Eduardo', 'Ramírez', 'Hernández', '3101234567', '3107654321', 'carlos.ramirez@email.com', 'Calle Falsa 123', 'admin'),
('9876543210', 'Elena', 'María', 'Gutiérrez', 'Pérez', '3109876543', '3108765432', 'elena.gutierrez@email.com', 'Calle Real 456', 'normal');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vendedores`
--

CREATE TABLE `vendedores` (
  `NID` varchar(20) NOT NULL,
  `primer_nombre` varchar(100) NOT NULL,
  `segundo_nombre` varchar(100) DEFAULT 'Desconocido',
  `primer_apellido` varchar(100) NOT NULL,
  `segundo_apellido` varchar(100) DEFAULT 'Desconocido',
  `telefono1` varchar(20) NOT NULL,
  `telefono2` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `id_proveedor` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vendedores`
--

INSERT INTO `vendedores` (`NID`, `primer_nombre`, `segundo_nombre`, `primer_apellido`, `segundo_apellido`, `telefono1`, `telefono2`, `correo`, `id_proveedor`) VALUES
('1122334455', 'Luis', 'Felipe', 'Sánchez', 'López', '3103214567', NULL, 'luis.sanchez@email.com', '1122334455'),
('1234567890', 'Carlos', 'Antonio', 'Moreno', 'Gutiérrez', '3101234567', NULL, 'carlos.moreno@email.com', '1234567890'),
('9876543210', 'Marta', 'Elena', 'Torres', 'Vega', '3109876543', '3107654321', 'marta.torres@email.com', '9876543210');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `ID` int(11) NOT NULL,
  `codigo_venta` varchar(20) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `id_cliente` varchar(20) DEFAULT NULL,
  `id_usuario` varchar(20) NOT NULL,
  `id_metodo_pago` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `cantidad` int(10) UNSIGNED NOT NULL,
  `notas` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`ID`, `codigo_venta`, `id_producto`, `id_cliente`, `id_usuario`, `id_metodo_pago`, `fecha`, `cantidad`, `notas`) VALUES
(1, '20241118-1', 1, '1234567890', '1234567890', 1, '2024-11-18', 10, 'Envío a domicilio'),
(2, '20241118-2', 2, '9876543210', '9876543210', 2, '2024-11-18', 5, 'Recogida en tienda'),
(3, '20241118-3', 3, '1122334455', '1122334455', 3, '2024-11-18', 2, 'Pago a consignación');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `ventas_view`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `ventas_view` (
`id` int(11)
,`codigo` varchar(20)
,`producto` varchar(100)
,`cantidad` int(10) unsigned
,`producto_precio` decimal(10,2)
,`producto_ganancia` decimal(5,2)
,`fecha_registro` date
,`cliente_primer_nombre` varchar(100)
,`cliente_segundo_nombre` varchar(100)
,`cliente_primer_apellido` varchar(100)
,`cliente_segundo_apellido` varchar(100)
,`usuario_primer_nombre` varchar(100)
,`usuario_segundo_nombre` varchar(100)
,`usuario_primer_apellido` varchar(100)
,`usuario_segundo_apellido` varchar(100)
,`metodo_de_pago` varchar(100)
,`notas` text
);

-- --------------------------------------------------------

--
-- Estructura para la vista `inventario`
--
DROP TABLE IF EXISTS `inventario`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `inventario`  AS SELECT `productos`.`ID` AS `id`, `productos`.`nombre` AS `nombre`, `productos`.`descripcion` AS `descripcion`, `categorias`.`nombre` AS `categoria`, `productos`.`precio_compra` AS `precio_compra`, `productos`.`porcentaje_ganancia` AS `ganancia`, `productos`.`cantidad_actual` AS `stock_actual`, `productos`.`cantidad_minima` AS `stock_minimo` FROM (`productos` join `categorias` on(`productos`.`id_categoria` = `categorias`.`ID`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `proveedores_con_vendedores`
--
DROP TABLE IF EXISTS `proveedores_con_vendedores`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `proveedores_con_vendedores`  AS SELECT `proveedores`.`RUT` AS `rut`, `proveedores`.`nombre` AS `nombre_proveedor`, `proveedores`.`telefono1` AS `proveedor_telefono_1`, `proveedores`.`telefono2` AS `proveedor_telefono_2`, `proveedores`.`correo` AS `proveedor_correo`, `proveedores`.`direccion` AS `direccion`, `vendedores`.`NID` AS `NID`, `vendedores`.`primer_nombre` AS `primer_nombre`, `vendedores`.`segundo_nombre` AS `segundo_nombre`, `vendedores`.`primer_apellido` AS `primer_apellido`, `vendedores`.`segundo_apellido` AS `segundo_apellido`, `vendedores`.`telefono1` AS `telefono1`, `vendedores`.`telefono2` AS `telefono2`, `vendedores`.`correo` AS `vendedor_correo` FROM (`proveedores` left join `vendedores` on(`proveedores`.`RUT` = `vendedores`.`id_proveedor`)) ORDER BY `proveedores`.`nombre` ASC, `vendedores`.`primer_nombre` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `registro_venta_productos`
--
DROP TABLE IF EXISTS `registro_venta_productos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `registro_venta_productos`  AS SELECT `productos`.`ID` AS `id`, `productos`.`nombre` AS `nombre`, `categorias`.`nombre` AS `categoria`, `productos`.`precio_compra` AS `precio_compra`, `productos`.`porcentaje_ganancia` AS `ganancia` FROM (`productos` join `categorias` on(`productos`.`id_categoria` = `categorias`.`ID`)) ORDER BY `productos`.`nombre` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `ventas_view`
--
DROP TABLE IF EXISTS `ventas_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `ventas_view`  AS SELECT `ventas`.`ID` AS `id`, `ventas`.`codigo_venta` AS `codigo`, `productos`.`nombre` AS `producto`, `ventas`.`cantidad` AS `cantidad`, `productos`.`precio_compra` AS `producto_precio`, `productos`.`porcentaje_ganancia` AS `producto_ganancia`, `ventas`.`fecha` AS `fecha_registro`, `clientes`.`primer_nombre` AS `cliente_primer_nombre`, `clientes`.`segundo_nombre` AS `cliente_segundo_nombre`, `clientes`.`primer_apellido` AS `cliente_primer_apellido`, `clientes`.`segundo_apellido` AS `cliente_segundo_apellido`, `usuarios`.`primer_nombre` AS `usuario_primer_nombre`, `usuarios`.`segundo_nombre` AS `usuario_segundo_nombre`, `usuarios`.`primer_apellido` AS `usuario_primer_apellido`, `usuarios`.`segundo_apellido` AS `usuario_segundo_apellido`, `metodos_de_pago`.`nombre` AS `metodo_de_pago`, `ventas`.`notas` AS `notas` FROM ((((`ventas` join `productos` on(`ventas`.`id_producto` = `productos`.`ID`)) join `clientes` on(`ventas`.`id_cliente` = `clientes`.`NID`)) join `usuarios` on(`ventas`.`id_usuario` = `usuarios`.`NID`)) join `metodos_de_pago` on(`ventas`.`id_metodo_pago` = `metodos_de_pago`.`ID`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`NID`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `metodos_de_pago`
--
ALTER TABLE `metodos_de_pago`
  ADD PRIMARY KEY (`ID`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `productos_compras`
--
ALTER TABLE `productos_compras`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_compra` (`id_compra`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`RUT`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`NID`);

--
-- Indices de la tabla `vendedores`
--
ALTER TABLE `vendedores`
  ADD PRIMARY KEY (`NID`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_metodo_pago` (`id_metodo_pago`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `metodos_de_pago`
--
ALTER TABLE `metodos_de_pago`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `productos_compras`
--
ALTER TABLE `productos_compras`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`RUT`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`ID`);

--
-- Filtros para la tabla `productos_compras`
--
ALTER TABLE `productos_compras`
  ADD CONSTRAINT `productos_compras_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`ID`),
  ADD CONSTRAINT `productos_compras_ibfk_2` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`ID`);

--
-- Filtros para la tabla `vendedores`
--
ALTER TABLE `vendedores`
  ADD CONSTRAINT `vendedores_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`RUT`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`ID`),
  ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`NID`),
  ADD CONSTRAINT `ventas_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`NID`),
  ADD CONSTRAINT `ventas_ibfk_4` FOREIGN KEY (`id_metodo_pago`) REFERENCES `metodos_de_pago` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
