-- Modificar un cliente
DELIMITER //

CREATE PROCEDURE ModificarCliente(
    IN p_NID VARCHAR(20),
    IN p_primer_nombre VARCHAR(50),
    IN p_segundo_nombre VARCHAR(50),
    IN p_primer_apellido VARCHAR(50),
    IN p_segundo_apellido VARCHAR(50),
    IN p_telefono VARCHAR(20),
    IN p_correo VARCHAR(100)
)
BEGIN
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
END //

DELIMITER ;

-- Modificar un producto
DELIMITER //

CREATE PROCEDURE ModificarProducto(
    IN p_id INT,
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_id_categoria INT,
    IN p_precio_compra DECIMAL(10, 2),
    IN p_porcentaje_ganancia DECIMAL(5, 2),
    IN p_cantidad_actual INT,
    IN p_cantidad_minima INT
)
BEGIN
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
END //

DELIMITER ;

-- Modificar una venta
DELIMITER //

CREATE PROCEDURE ModificarVenta(
    IN p_codigo_venta VARCHAR(20),
    IN p_id_producto INT,
    IN p_id_cliente VARCHAR(20),
    IN p_id_usuario VARCHAR(20),
    IN p_id_metodo_pago INT,
    IN p_fecha DATE,
    IN p_notas TEXT
)
BEGIN
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
END //

DELIMITER ;

-- Modificar un proveedor
DELIMITER //

CREATE PROCEDURE ModificarProveedor(
    IN p_RUT VARCHAR(20),
    IN p_nombre VARCHAR(100),
    IN p_telefono1 VARCHAR(20),
    IN p_telefono2 VARCHAR(20),
    IN p_correo VARCHAR(100),
    IN p_direccion VARCHAR(255)
)
BEGIN
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
END //

DELIMITER ;

-- Modificar un vendedor
DELIMITER //

CREATE PROCEDURE ModificarVendedor(
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
END //

DELIMITER ;

-- Modificar un usuario
DELIMITER //

CREATE PROCEDURE ModificarUsuario(
    IN p_NID VARCHAR(20),
    IN p_primer_nombre VARCHAR(50),
    IN p_segundo_nombre VARCHAR(50),
    IN p_primer_apellido VARCHAR(50),
    IN p_segundo_apellido VARCHAR(50),
    IN p_telefono1 VARCHAR(20),
    IN p_telefono2 VARCHAR(20),
    IN p_correo VARCHAR(100),
    IN p_direccion VARCHAR(255),
    IN p_tipo VARCHAR(20)
)
BEGIN
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
END //

DELIMITER ;

-- Modificar una compra
DELIMITER //

CREATE PROCEDURE ModificarCompra(
    IN p_id_compra INT,
    IN p_id_proveedor VARCHAR(20),
    IN p_fecha_orden DATE,
    IN p_total_pagar DECIMAL(10,2),
    IN p_fecha_pago DATE
)
BEGIN
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
END //

DELIMITER ;