-- Insertar una categoría
DELIMITER //

CREATE PROCEDURE InsertarCategoria(
    IN p_nombre VARCHAR(50)
)
BEGIN
    -- Validar que el nombre no esté vacío
    IF p_nombre IS NULL OR p_nombre = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre de la categoría no puede estar vacío';
    END IF;

    -- Insertar la categoría
    INSERT INTO Categorias (nombre) VALUES (p_nombre);

    SELECT 'Categoría insertada correctamente' AS mensaje;
END //

DELIMITER ;

-- Insertar un cliente
DELIMITER //

CREATE PROCEDURE InsertarCliente(
    IN p_NID VARCHAR(20),
    IN p_primer_nombre VARCHAR(50),
    IN p_segundo_nombre VARCHAR(50),
    IN p_primer_apellido VARCHAR(50),
    IN p_segundo_apellido VARCHAR(50),
    IN p_telefono1 VARCHAR(20),
    IN p_telefono2 VARCHAR(20),
    IN p_correo VARCHAR(100)
)
BEGIN
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
END //

DELIMITER ;

-- Insertar una compra
DELIMITER //

CREATE PROCEDURE InsertarCompra(
    IN p_id_proveedor VARCHAR(20),
    IN p_fecha_orden DATE,
    IN p_total_pagar DECIMAL(10,2),
    IN p_fecha_pago DATE
)
BEGIN
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
END //

DELIMITER ;

-- Insertar un método de pago
DELIMITER //

CREATE PROCEDURE InsertarMetodoPago(
    IN p_nombre VARCHAR(50)
)
BEGIN
    -- Validar que el nombre no esté vacío
    IF p_nombre IS NULL OR p_nombre = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre del método de pago no puede estar vacío';
    END IF;

    -- Insertar el método de pago
    INSERT INTO Metodos_de_pago (nombre) VALUES (p_nombre);

    SELECT 'Método de pago insertado correctamente' AS mensaje;
END //

DELIMITER ;

-- Insertar un producto
DELIMITER //

CREATE PROCEDURE InsertarProducto(
    IN p_nombre VARCHAR(100),
    IN p_descripcion VARCHAR(255),
    IN p_id_categoria INT,
    IN p_precio_compra DECIMAL(10,2),
    IN p_porcentaje_ganancia DECIMAL(5,2),
    IN p_cantidad_actual INT,
    IN p_cantidad_minima INT
)
BEGIN
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
END //

DELIMITER ;

-- Insertar un registro Producto-Compra
DELIMITER //

CREATE PROCEDURE InsertarProductoCompra(
    IN p_id_producto INT,
    IN p_id_compra INT
)
BEGIN
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
END //

DELIMITER ;

-- Insertar un proveedor
DELIMITER //

CREATE PROCEDURE InsertarProveedor(
    IN p_RUT VARCHAR(20),
    IN p_nombre VARCHAR(100),
    IN p_telefono1 VARCHAR(20),
    IN p_telefono2 VARCHAR(20),
    IN p_correo VARCHAR(100),
    IN p_direccion VARCHAR(255)
)
BEGIN
    -- Validar que el RUT no esté vacío
    IF p_RUT IS NULL OR p_RUT = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El RUT no puede estar vacío';
    END IF;

    -- Insertar el proveedor
    INSERT INTO Proveedores (RUT, nombre, telefono1, telefono2, correo, direccion)
    VALUES (p_RUT, p_nombre, p_telefono1, p_telefono2, p_correo, p_direccion);

    SELECT 'Proveedor insertado correctamente' AS mensaje;
END //

DELIMITER ;

-- Insertar un usuario
DELIMITER //

CREATE PROCEDURE InsertarUsuario(
    IN p_NID VARCHAR(20),
    IN p_primer_nombre VARCHAR(50),
    IN p_segundo_nombre VARCHAR(50),
    IN p_primer_apellido VARCHAR(50),
    IN p_segundo_apellido VARCHAR(50),
    IN p_telefono1 VARCHAR(20),
    IN p_telefono2 VARCHAR(20),
    IN p_correo VARCHAR(100),
    IN p_direccion VARCHAR(255),
    IN p_tipo INT
)
BEGIN
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
END //

DELIMITER ;

-- Insertar un vendedor

DELIMITER //

CREATE PROCEDURE InsertarVendedor(
    IN p_NID VARCHAR(20),
    IN p_primer_nombre VARCHAR(50),
    IN p_segundo_nombre VARCHAR(50),
    IN p_primer_apellido VARCHAR(50),
    IN p_segundo_apellido VARCHAR(50),
    IN p_telefono1 VARCHAR(20),
    IN p_telefono2 VARCHAR(20),
    IN p_correo VARCHAR(100),
    IN p_id_proveedor VARCHAR(20)
)
BEGIN
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
END //

DELIMITER ;

-- Insertar una venta
DELIMITER //

CREATE PROCEDURE InsertarVenta(
    IN p_codigo_venta VARCHAR(20),
    IN p_id_cliente VARCHAR(20),
    IN p_id_usuario VARCHAR(20),
    IN p_id_metodo_pago INT,
    IN p_fecha DATE,
    IN p_notas VARCHAR(255)
)
BEGIN
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
END //

DELIMITER ;
