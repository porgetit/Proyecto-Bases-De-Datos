-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-11-2024 a las 07:39:44
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

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarCliente` (IN `p_NID` VARCHAR(20))   BEGIN
    -- Validar existencia del cliente
    IF NOT EXISTS (SELECT 1 FROM Clientes WHERE NID = p_NID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente no encontrado';
    END IF;

    -- Validar que el cliente no esté asociado a ventas
    IF EXISTS (SELECT 1 FROM Ventas WHERE id_cliente = p_NID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar: cliente está asociado a ventas';
    END IF;

    -- Eliminar cliente
    DELETE FROM Clientes WHERE NID = p_NID;

    SELECT 'Cliente eliminado correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarCompra` (IN `p_id_compra` INT)   BEGIN
    -- Validar existencia de la compra
    IF NOT EXISTS (SELECT 1 FROM Compras WHERE ID = p_id_compra) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Compra no encontrada';
    END IF;

    -- Validar que la compra no esté asociada a productos
    IF EXISTS (SELECT 1 FROM Productos_Compras WHERE id_compra = p_id_compra) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar: compra está asociada a productos';
    END IF;

    -- Eliminar compra
    DELETE FROM Compras WHERE ID = p_id_compra;

    SELECT 'Compra eliminada correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarProducto` (IN `p_id_producto` INT)   BEGIN
    -- Validar existencia del producto
    IF NOT EXISTS (SELECT 1 FROM Productos WHERE ID = p_id_producto) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producto no encontrado';
    END IF;

    -- Validar que el producto no esté asociado a ventas
    IF EXISTS (SELECT 1 FROM Ventas WHERE id_producto = p_id_producto) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar: producto está asociado a ventas';
    END IF;

    -- Eliminar producto
    DELETE FROM Productos WHERE ID = p_id_producto;

    SELECT 'Producto eliminado correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarProveedor` (IN `p_RUT` VARCHAR(20))   BEGIN
    -- Validar existencia del proveedor
    IF NOT EXISTS (SELECT 1 FROM Proveedores WHERE RUT = p_RUT) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Proveedor no encontrado';
    END IF;

    -- Validar que el proveedor no esté asociado a productos
    IF EXISTS (SELECT 1 FROM Productos WHERE id_proveedor = p_RUT) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar: proveedor está asociado a productos';
    END IF;

    -- Eliminar proveedor
    DELETE FROM Proveedores WHERE RUT = p_RUT;

    SELECT 'Proveedor eliminado correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarUsuario` (IN `p_NID` VARCHAR(20))   BEGIN
    -- Validar existencia del usuario
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NID = p_NID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Usuario no encontrado';
    END IF;

    -- Eliminar usuario
    DELETE FROM Usuarios WHERE NID = p_NID;

    SELECT 'Usuario eliminado correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarVendedor` (IN `p_NID` VARCHAR(20))   BEGIN
    -- Validar existencia del vendedor
    IF NOT EXISTS (SELECT 1 FROM Vendedores WHERE NID = p_NID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Vendedor no encontrado';
    END IF;

    -- Validar que el vendedor no esté asociado a ventas
    IF EXISTS (SELECT 1 FROM Ventas WHERE id_usuario = p_NID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar: vendedor está asociado a ventas';
    END IF;

    -- Eliminar vendedor
    DELETE FROM Vendedores WHERE NID = p_NID;

    SELECT 'Vendedor eliminado correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarVenta` (IN `p_codigo_venta` VARCHAR(20))   BEGIN
    -- Validar existencia de la venta
    IF NOT EXISTS (SELECT 1 FROM Ventas WHERE codigo_venta = p_codigo_venta) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Venta no encontrada';
    END IF;

    -- Eliminar venta
    DELETE FROM Ventas WHERE codigo_venta = p_codigo_venta;

    SELECT 'Venta eliminada correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarCategoria` (IN `p_nombre` VARCHAR(50))   BEGIN
    -- Validar que el nombre no esté vacío
    IF p_nombre IS NULL OR p_nombre = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre de la categoría no puede estar vacío';
    END IF;

    -- Insertar la categoría
    INSERT INTO Categorias (nombre) VALUES (p_nombre);

    SELECT 'Categoría insertada correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarCliente` (IN `p_NID` VARCHAR(20), IN `p_primer_nombre` VARCHAR(50), IN `p_segundo_nombre` VARCHAR(50), IN `p_primer_apellido` VARCHAR(50), IN `p_segundo_apellido` VARCHAR(50), IN `p_telefono1` VARCHAR(20), IN `p_telefono2` VARCHAR(20), IN `p_correo` VARCHAR(100))   BEGIN
    -- Validar que el NID no esté vacío
    IF p_NID IS NULL OR p_NID = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El NID no puede estar vacío';
    END IF;

    -- Validar que el correo tenga el formato correcto
    IF p_correo IS NOT NULL AND p_correo NOT LIKE '%@%.%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Correo electrónico no válido';
    END IF;

    -- Insertar el cliente
    INSERT INTO Clientes (NID, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono1, telefono2, correo)
    VALUES (p_NID, p_primer_nombre, p_segundo_nombre, p_primer_apellido, p_segundo_apellido, p_telefono1, p_telefono2, p_correo);

    SELECT 'Cliente insertado correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarCompra` (IN `p_id_proveedor` VARCHAR(20), IN `p_fecha_orden` DATE, IN `p_total_pagar` DECIMAL(10,2), IN `p_fecha_pago` DATE)   BEGIN
    -- Validar existencia del proveedor
    IF NOT EXISTS (SELECT 1 FROM Proveedores WHERE RUT = p_id_proveedor) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Proveedor no encontrado';
    END IF;

    -- Validar que el total a pagar sea mayor que 0
    IF p_total_pagar <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El total a pagar debe ser mayor que 0';
    END IF;

    -- Insertar la compra
    INSERT INTO Compras (id_proveedor, fecha_orden, total_pagar, fecha_pago)
    VALUES (p_id_proveedor, p_fecha_orden, p_total_pagar, p_fecha_pago);

    SELECT 'Compra insertada correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarMetodoPago` (IN `p_nombre` VARCHAR(50))   BEGIN
    -- Validar que el nombre no esté vacío
    IF p_nombre IS NULL OR p_nombre = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre del método de pago no puede estar vacío';
    END IF;

    -- Insertar el método de pago
    INSERT INTO Metodos_de_pago (nombre) VALUES (p_nombre);

    SELECT 'Método de pago insertado correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarProducto` (IN `p_nombre` VARCHAR(100), IN `p_descripcion` VARCHAR(255), IN `p_id_categoria` INT, IN `p_precio_compra` DECIMAL(10,2), IN `p_porcentaje_ganancia` DECIMAL(5,2), IN `p_cantidad_actual` INT, IN `p_cantidad_minima` INT)   BEGIN
    -- Validar que la categoría exista
    IF NOT EXISTS (SELECT 1 FROM Categorias WHERE ID = p_id_categoria) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Categoría no encontrada';
    END IF;

    -- Validar que el precio de compra sea mayor que 0
    IF p_precio_compra <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio de compra debe ser mayor que 0';
    END IF;

    -- Insertar el producto
    INSERT INTO Productos (nombre, descripcion, id_categoria, precio_compra, porcentaje_ganancia, cantidad_actual, cantidad_minima)
    VALUES (p_nombre, p_descripcion, p_id_categoria, p_precio_compra, p_porcentaje_ganancia, p_cantidad_actual, p_cantidad_minima);

    SELECT 'Producto insertado correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarProductoCompra` (IN `p_id_producto` INT, IN `p_id_compra` INT)   BEGIN
    -- Validar que el producto y la compra existan
    IF NOT EXISTS (SELECT 1 FROM Productos WHERE ID = p_id_producto) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producto no encontrado';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Compras WHERE ID = p_id_compra) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Compra no encontrada';
    END IF;

    -- Insertar el producto en la compra
    INSERT INTO Productos_Compras (id_producto, id_compra)
    VALUES (p_id_producto, p_id_compra);

    SELECT 'Producto añadido a compra correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarProveedor` (IN `p_RUT` VARCHAR(20), IN `p_nombre` VARCHAR(100), IN `p_telefono1` VARCHAR(20), IN `p_telefono2` VARCHAR(20), IN `p_correo` VARCHAR(100), IN `p_direccion` VARCHAR(255))   BEGIN
    -- Validar que el RUT no esté vacío
    IF p_RUT IS NULL OR p_RUT = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El RUT no puede estar vacío';
    END IF;

    -- Insertar el proveedor
    INSERT INTO Proveedores (RUT, nombre, telefono1, telefono2, correo, direccion)
    VALUES (p_RUT, p_nombre, p_telefono1, p_telefono2, p_correo, p_direccion);

    SELECT 'Proveedor insertado correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarUsuario` (IN `p_NID` VARCHAR(20), IN `p_primer_nombre` VARCHAR(50), IN `p_segundo_nombre` VARCHAR(50), IN `p_primer_apellido` VARCHAR(50), IN `p_segundo_apellido` VARCHAR(50), IN `p_telefono1` VARCHAR(20), IN `p_telefono2` VARCHAR(20), IN `p_correo` VARCHAR(100), IN `p_direccion` VARCHAR(255), IN `p_tipo` INT)   BEGIN
    -- Validar que el NID no esté vacío
    IF p_NID IS NULL OR p_NID = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El NID no puede estar vacío';
    END IF;

    -- Validar que el correo tenga el formato correcto
    IF p_correo IS NOT NULL AND p_correo NOT LIKE '%@%.%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Correo electrónico no válido';
    END IF;

    -- Insertar el usuario
    INSERT INTO Usuarios (NID, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono1, telefono2, correo, direccion, tipo)
    VALUES (p_NID, p_primer_nombre, p_segundo_nombre, p_primer_apellido, p_segundo_apellido, p_telefono1, p_telefono2, p_correo, p_direccion, p_tipo);

    SELECT 'Usuario insertado correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarVendedor` (IN `p_NID` VARCHAR(20), IN `p_primer_nombre` VARCHAR(50), IN `p_segundo_nombre` VARCHAR(50), IN `p_primer_apellido` VARCHAR(50), IN `p_segundo_apellido` VARCHAR(50), IN `p_telefono1` VARCHAR(20), IN `p_telefono2` VARCHAR(20), IN `p_correo` VARCHAR(100), IN `p_id_proveedor` VARCHAR(20))   BEGIN
    -- Validar que el NID no esté vacío
    IF p_NID IS NULL OR p_NID = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El NID no puede estar vacío';
    END IF;

    -- Validar que el proveedor exista
    IF NOT EXISTS (SELECT 1 FROM Proveedores WHERE RUT = p_id_proveedor) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Proveedor no encontrado';
    END IF;

    -- Insertar el vendedor
    INSERT INTO Vendedores (NID, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono1, telefono2, correo, id_proveedor)
    VALUES (p_NID, p_primer_nombre, p_segundo_nombre, p_primer_apellido, p_segundo_apellido, p_telefono1, p_telefono2, p_correo, p_id_proveedor);

    SELECT 'Vendedor insertado correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarVenta` (IN `p_codigo_venta` VARCHAR(20), IN `p_id_cliente` VARCHAR(20), IN `p_id_usuario` VARCHAR(20), IN `p_id_metodo_pago` INT, IN `p_fecha` DATE, IN `p_notas` VARCHAR(255))   BEGIN
    -- Validar que el cliente exista
    IF NOT EXISTS (SELECT 1 FROM Clientes WHERE NID = p_id_cliente) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente no encontrado';
    END IF;

    -- Validar que el usuario exista
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NID = p_id_usuario) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Usuario no encontrado';
    END IF;

    -- Validar que el método de pago exista
    IF NOT EXISTS (SELECT 1 FROM Metodos_de_pago WHERE ID = p_id_metodo_pago) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Método de pago no encontrado';
    END IF;

    -- Insertar la venta
    INSERT INTO Ventas (codigo, id_cliente, id_usuario, id_metodo_pago, fecha, notas)
    VALUES (p_codigo_venta, p_id_cliente, p_id_usuario, p_id_metodo_pago, p_fecha, p_notas);

    SELECT 'Venta insertada correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarCliente` (IN `p_NID` VARCHAR(20), IN `p_primer_nombre` VARCHAR(50), IN `p_segundo_nombre` VARCHAR(50), IN `p_primer_apellido` VARCHAR(50), IN `p_segundo_apellido` VARCHAR(50), IN `p_telefono` VARCHAR(20), IN `p_correo` VARCHAR(100))   BEGIN
    -- Validación de existencia del cliente
    IF NOT EXISTS (SELECT 1 FROM Clientes WHERE NID = p_NID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cliente no encontrado';
    END IF;
    
    -- Validación de correo electrónico (si se proporciona)
    IF p_correo IS NOT NULL AND NOT p_correo LIKE '%@%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Correo electrónico no válido';
    END IF;
    
    -- Modificar el cliente
    UPDATE Clientes
    SET 
        primer_nombre = p_primer_nombre,
        segundo_nombre = p_segundo_nombre,
        primer_apellido = p_primer_apellido,
        segundo_apellido = p_segundo_apellido,
        telefono = p_telefono,
        correo = p_correo
    WHERE NID = p_NID;
    
    SELECT 'Cliente modificado correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarCompra` (IN `p_id_compra` INT, IN `p_id_proveedor` VARCHAR(20), IN `p_fecha_orden` DATE, IN `p_total_pagar` DECIMAL(10,2), IN `p_fecha_pago` DATE)   BEGIN
    -- Validación de existencia de la compra
    IF NOT EXISTS (SELECT 1 FROM Compras WHERE ID = p_id_compra) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Compra no encontrada';
    END IF;

    -- Validación del proveedor (debe existir en la tabla Proveedores)
    IF NOT EXISTS (SELECT 1 FROM Proveedores WHERE RUT = p_id_proveedor) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Proveedor no encontrado';
    END IF;

    -- Validación de fecha de pago (debe ser posterior a la fecha de orden)
    IF p_fecha_pago <= p_fecha_orden THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La fecha de pago debe ser posterior a la fecha de orden';
    END IF;

    -- Modificar la compra
    UPDATE Compras
    SET 
        id_proveedor = p_id_proveedor,
        fecha_orden = p_fecha_orden,
        total_pagar = p_total_pagar,
        fecha_pago = p_fecha_pago
    WHERE ID = p_id_compra;

    SELECT 'Compra modificada correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarProducto` (IN `p_id` INT, IN `p_nombre` VARCHAR(100), IN `p_descripcion` TEXT, IN `p_id_categoria` INT, IN `p_precio_compra` DECIMAL(10,2), IN `p_porcentaje_ganancia` DECIMAL(5,2), IN `p_cantidad_actual` INT, IN `p_cantidad_minima` INT)   BEGIN
    -- Validación de existencia del producto
    IF NOT EXISTS (SELECT 1 FROM Productos WHERE ID = p_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Producto no encontrado';
    END IF;

    -- Modificar el producto
    UPDATE Productos
    SET 
        nombre = p_nombre,
        descripcion = p_descripcion,
        id_categoria = p_id_categoria,
        precio_compra = p_precio_compra,
        porcentaje_ganancia = p_porcentaje_ganancia,
        cantidad_actual = p_cantidad_actual,
        cantidad_minima = p_cantidad_minima
    WHERE ID = p_id;
    
    SELECT 'Producto modificado correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarProveedor` (IN `p_RUT` VARCHAR(20), IN `p_nombre` VARCHAR(100), IN `p_telefono1` VARCHAR(20), IN `p_telefono2` VARCHAR(20), IN `p_correo` VARCHAR(100), IN `p_direccion` VARCHAR(255))   BEGIN
    -- Validación de existencia del proveedor
    IF NOT EXISTS (SELECT 1 FROM Proveedores WHERE RUT = p_RUT) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Proveedor no encontrado';
    END IF;

    -- Modificar el proveedor
    UPDATE Proveedores
    SET 
        nombre = p_nombre,
        telefono1 = p_telefono1,
        telefono2 = p_telefono2,
        correo = p_correo,
        direccion = p_direccion
    WHERE RUT = p_RUT;

    SELECT 'Proveedor modificado correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarUsuario` (IN `p_NID` VARCHAR(20), IN `p_primer_nombre` VARCHAR(50), IN `p_segundo_nombre` VARCHAR(50), IN `p_primer_apellido` VARCHAR(50), IN `p_segundo_apellido` VARCHAR(50), IN `p_telefono1` VARCHAR(20), IN `p_telefono2` VARCHAR(20), IN `p_correo` VARCHAR(100), IN `p_direccion` VARCHAR(255), IN `p_tipo` VARCHAR(20))   BEGIN
    -- Validación de existencia del usuario
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NID = p_NID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Usuario no encontrado';
    END IF;

    -- Validación de correo electrónico (si se proporciona)
    IF p_correo IS NOT NULL AND NOT p_correo LIKE '%@%' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Correo electrónico no válido';
    END IF;

    -- Modificar el usuario
    UPDATE Usuarios
    SET 
        primer_nombre = p_primer_nombre,
        segundo_nombre = p_segundo_nombre,
        primer_apellido = p_primer_apellido,
        segundo_apellido = p_segundo_apellido,
        telefono1 = p_telefono1,
        telefono2 = p_telefono2,
        correo = p_correo,
        direccion = p_direccion,
        tipo = p_tipo
    WHERE NID = p_NID;

    SELECT 'Usuario modificado correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarVendedor` (IN `p_NID` VARCHAR(20), IN `p_primer_nombre` VARCHAR(50), IN `p_segundo_nombre` VARCHAR(50), IN `p_primer_apellido` VARCHAR(50), IN `p_segundo_apellido` VARCHAR(50), IN `p_telefono1` VARCHAR(20), IN `p_telefono2` VARCHAR(20), IN `p_correo` VARCHAR(100), IN `p_id_proveedor` VARCHAR(20))   BEGIN
    -- Validación de existencia del vendedor
    IF NOT EXISTS (SELECT 1 FROM Vendedores WHERE NID = p_NID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Vendedor no encontrado';
    END IF;

    -- Validación de proveedor
    IF NOT EXISTS (SELECT 1 FROM Proveedores WHERE RUT = p_id_proveedor) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Proveedor no encontrado';
    END IF;

    -- Modificar el vendedor
    UPDATE Vendedores
    SET 
        primer_nombre = p_primer_nombre,
        segundo_nombre = p_segundo_nombre,
        primer_apellido = p_primer_apellido,
        segundo_apellido = p_segundo_apellido,
        telefono1 = p_telefono1,
        telefono2 = p_telefono2,
        correo = p_correo,
        id_proveedor = p_id_proveedor
    WHERE NID = p_NID;

    SELECT 'Vendedor modificado correctamente' AS mensaje;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarVenta` (IN `p_codigo_venta` VARCHAR(20), IN `p_id_producto` INT, IN `p_id_cliente` VARCHAR(20), IN `p_id_usuario` VARCHAR(20), IN `p_id_metodo_pago` INT, IN `p_fecha` DATE, IN `p_notas` TEXT)   BEGIN
    -- Validación de existencia de la venta
    IF NOT EXISTS (SELECT 1 FROM Ventas WHERE codigo_venta = p_codigo_venta) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Venta no encontrada';
    END IF;

    -- Modificar la venta
    UPDATE Ventas
    SET 
        id_producto = p_id_producto,
        id_cliente = p_id_cliente,
        id_usuario = p_id_usuario,
        id_metodo_pago = p_id_metodo_pago,
        fecha = p_fecha,
        notas = p_notas
    WHERE codigo_venta = p_codigo_venta;
    
    SELECT 'Venta modificada correctamente' AS mensaje;
END$$

DELIMITER ;

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
  `notas` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`ID`, `codigo_venta`, `id_producto`, `id_cliente`, `id_usuario`, `id_metodo_pago`, `fecha`, `notas`) VALUES
(1, '20241118-1', 1, '1234567890', '1234567890', 1, '2024-11-18', 'Envío a domicilio'),
(2, '20241118-2', 2, '9876543210', '9876543210', 2, '2024-11-18', 'Recogida en tienda'),
(3, '20241118-3', 3, '1122334455', '1122334455', 3, '2024-11-18', 'Pago a consignación');

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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
