
-- TODO Debo verificar estas vistas, creo que algunas no son lógicas o pueden resultar innecesarias. Hay indicios de que GPT alucinó en algunos casos.

-- Vista de ventas, cliente y producto
CREATE VIEW VistaVentasDetalle AS
SELECT 
    v.ID AS id_venta,
    v.codigo AS codigo_venta,
    v.fecha AS fecha_venta,
    c.NID AS cliente_NID,
    c.primer_nombre AS cliente_primer_nombre,
    c.segundo_nombre AS cliente_segundo_nombre,
    c.primer_apellido AS cliente_primer_apellido,
    c.segundo_apellido AS cliente_segundo_apellido,
    p.nombre AS producto_nombre,
    p.precio_compra AS precio_producto,
    mp.nombre AS metodo_pago,
    u.NID AS vendedor_NID,
    u.primer_nombre AS vendedor_primer_nombre,
    u.segundo_nombre AS vendedor_segundo_nombre
FROM Ventas v
JOIN Clientes c ON v.id_cliente = c.NID
JOIN Metodos_de_pago mp ON v.id_metodo_pago = mp.ID
JOIN Usuarios u ON v.id_usuario = u.NID
JOIN Productos p ON p.ID = v.id_producto;  -- Asumiendo que se tienen productos en cada venta

-- Productos con categoría
CREATE VIEW VistaProductosConCategoria AS
SELECT 
    p.ID AS id_producto,
    p.nombre AS producto_nombre,
    p.descripcion AS producto_descripcion,
    c.nombre AS categoria_nombre,
    p.precio_compra,
    p.cantidad_actual,
    p.cantidad_minima
FROM Productos p
JOIN Categorias c ON p.id_categoria = c.ID;

-- Clientes con ventas realizadas
CREATE VIEW VistaClientesVentas AS
SELECT 
    c.NID AS cliente_NID,
    c.primer_nombre AS cliente_primer_nombre,
    c.segundo_nombre AS cliente_segundo_nombre,
    c.primer_apellido AS cliente_primer_apellido,
    c.segundo_apellido AS cliente_segundo_apellido,
    COUNT(v.ID) AS total_ventas,
    SUM(p.precio_compra) AS total_gastado
FROM Clientes c
LEFT JOIN Ventas v ON c.NID = v.id_cliente
JOIN Productos p ON v.id_producto = p.ID
GROUP BY c.NID;

-- Inventario de productos
CREATE VIEW VistaInventarioProductos AS
SELECT 
    p.ID AS id_producto,
    p.nombre AS producto_nombre,
    p.descripcion AS producto_descripcion,
    c.nombre AS categoria_nombre,
    p.cantidad_actual,
    p.cantidad_minima,
    p.precio_compra
FROM Productos p
JOIN Categorias c ON p.id_categoria = c.ID
WHERE p.cantidad_actual < p.cantidad_minima;

-- Compras con proveedor y productos
CREATE VIEW VistaComprasDetalle AS
SELECT 
    c.ID AS id_compra,
    c.fecha_orden AS fecha_orden,
    c.total_pagar AS total_pagar,
    c.fecha_pago AS fecha_pago,
    p.nombre AS producto_nombre,
    p.precio_compra,
    pr.nombre AS proveedor_nombre
FROM Compras c
JOIN Proveedores pr ON c.id_proveedor = pr.RUT
JOIN Productos p ON p.ID = c.id_producto;  -- Si la tabla "Productos_Compras" está involucrada, puedes ajustar aquí

-- Productos con proveedores
CREATE VIEW VistaProductosProveedores AS
SELECT 
    p.ID AS id_producto,
    p.nombre AS producto_nombre,
    pr.RUT AS proveedor_RUT,
    pr.nombre AS proveedor_nombre
FROM Productos p
JOIN Proveedores pr ON p.id_proveedor = pr.RUT;

-- Productos con ventas
CREATE VIEW VistaProductosEnVentas AS
SELECT 
    p.ID AS id_producto,
    p.nombre AS producto_nombre,
    SUM(vp.cantidad) AS cantidad_vendida
FROM Productos p
JOIN Ventas v ON v.id_producto = p.ID
GROUP BY p.ID;

-- Métodos de pago con ventas
CREATE VIEW VistaMetodosPagoVentas AS
SELECT 
    mp.nombre AS metodo_pago,
    COUNT(v.ID) AS total_ventas,
    SUM(p.precio_compra) AS total_ingresos
FROM Metodos_de_pago mp
JOIN Ventas v ON v.id_metodo_pago = mp.ID
JOIN Productos p ON v.id_producto = p.ID
GROUP BY mp.ID;

-- Proveedores con ventas de sus productos
CREATE VIEW VistaProveedoresVentasProductos AS
SELECT 
    pr.RUT AS proveedor_RUT,
    pr.nombre AS proveedor_nombre,
    p.nombre AS producto_nombre,
    SUM(vp.cantidad) AS cantidad_vendida
FROM Proveedores pr
JOIN Productos p ON pr.RUT = p.id_proveedor
JOIN Ventas v ON p.ID = v.id_producto
GROUP BY pr.RUT, p.ID;

-- Resumen de ventas y compras
CREATE VIEW VistaResumenVentasCompras AS
SELECT 
    'Ventas' AS tipo_transaccion,
    COUNT(v.ID) AS total_ventas,
    SUM(p.precio_compra) AS ingresos
FROM Ventas v
JOIN Productos p ON v.id_producto = p.ID
UNION ALL
SELECT 
    'Compras' AS tipo_transaccion,
    COUNT(c.ID) AS total_compras,
    SUM(p.precio_compra) AS egresos
FROM Compras c
JOIN Productos p ON c.id_producto = p.ID;
