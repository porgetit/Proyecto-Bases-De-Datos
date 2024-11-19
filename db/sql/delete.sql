-- Eliminar un cliente
DELIMITER //

CREATE PROCEDURE EliminarCliente(
    IN p_NID VARCHAR(20)
)
BEGIN
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
END //

DELIMITER ;

-- Eliminar una compra
DELIMITER //

CREATE PROCEDURE EliminarCompra(
    IN p_id_compra INT
)
BEGIN
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
END //

DELIMITER ;

-- Eliminar un producto
DELIMITER //

CREATE PROCEDURE EliminarProducto(
    IN p_id_producto INT
)
BEGIN
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
END //

DELIMITER ;

-- Eliminar un proveedor
DELIMITER //

CREATE PROCEDURE EliminarProveedor(
    IN p_RUT VARCHAR(20)
)
BEGIN
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
END //

DELIMITER ;

-- Eliminar un usuario
DELIMITER //

CREATE PROCEDURE EliminarUsuario(
    IN p_NID VARCHAR(20)
)
BEGIN
    -- Validar existencia del usuario
    IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE NID = p_NID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Usuario no encontrado';
    END IF;

    -- Eliminar usuario
    DELETE FROM Usuarios WHERE NID = p_NID;

    SELECT 'Usuario eliminado correctamente' AS mensaje;
END //

DELIMITER ;

-- Eliminar un vendedor
DELIMITER //

CREATE PROCEDURE EliminarVendedor(
    IN p_NID VARCHAR(20)
)
BEGIN
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
END //

DELIMITER ;

-- Eliminar un venta
DELIMITER //

CREATE PROCEDURE EliminarVenta(
    IN p_codigo_venta VARCHAR(20)
)
BEGIN
    -- Validar existencia de la venta
    IF NOT EXISTS (SELECT 1 FROM Ventas WHERE codigo_venta = p_codigo_venta) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Venta no encontrada';
    END IF;

    -- Eliminar venta
    DELETE FROM Ventas WHERE codigo_venta = p_codigo_venta;

    SELECT 'Venta eliminada correctamente' AS mensaje;
END //

DELIMITER ;
