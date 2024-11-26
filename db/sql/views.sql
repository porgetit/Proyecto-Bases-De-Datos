-- Vista para ventas.php
create view ventas_view as
SELECT 
    ventas.ID AS id,
    ventas.codigo_venta AS codigo,
    productos.nombre AS producto,
    ventas.cantidad,
    productos.precio_compra AS producto_precio,
    productos.porcentaje_ganancia AS producto_ganancia,
    ventas.fecha AS fecha_registro,
    clientes.primer_nombre AS cliente_primer_nombre,
    clientes.segundo_nombre AS cliente_segundo_nombre,
    clientes.primer_apellido AS cliente_primer_apellido,
    clientes.segundo_apellido AS cliente_segundo_apellido,
    usuarios.primer_nombre AS usuario_primer_nombre,
    usuarios.segundo_nombre AS usuario_segundo_nombre,
    usuarios.primer_apellido AS usuario_primer_apellido,
    usuarios.segundo_apellido AS usuario_segundo_apellido,
    metodos_de_pago.nombre AS metodo_de_pago,
    ventas.notas AS notas
FROM Ventas
JOIN Productos ON Ventas.id_producto = Productos.ID
JOIN Clientes ON Ventas.id_cliente = Clientes.NID
JOIN Usuarios ON Ventas.id_usuario = Usuarios.NID
JOIN Metodos_de_pago ON Ventas.id_metodo_pago = Metodos_de_pago.ID;

-- Vista para invetario.php
CREATE VIEW inventario AS
SELECT
	productos.ID as id,
    productos.nombre as nombre,
    productos.descripcion as descripcion,
    categorias.nombre as categoria,
    productos.precio_compra as precio_compra,
    productos.porcentaje_ganancia as ganancia,
    productos.cantidad_actual as stock_actual,
    productos.cantidad_minima as stock_minimo
from productos join categorias on productos.id_categoria = categorias.ID;

-- Vista para proveedores.php
create view proveedores_con_vendedores as
select
	proveedores.rut,
    proveedores.nombre as nombre_proveedor,
    proveedores.telefono1 as proveedor_telefono_1,
    proveedores.telefono2 as proveedor_telefono_2,
    proveedores.correo as proveedor_correo,
    proveedores.direccion,
    vendedores.NID,
    vendedores.primer_nombre,
    vendedores.segundo_nombre,
    vendedores.primer_apellido,
    vendedores.segundo_apellido,
    vendedores.telefono1,
    vendedores.telefono2,
    vendedores.correo as vendedor_correo
from proveedores left join vendedores on proveedores.RUT = vendedores.id_proveedor
order by proveedores.nombre, vendedores.primer_nombre;

-- Vista para el selector de productos en registro_venta.php
create view registro_venta_productos as
select 
	productos.ID as id,
	productos.nombre, 
    categorias.nombre as categoria, 
    productos.precio_compra, 
    productos.porcentaje_ganancia as ganancia
from productos join categorias on productos.id_categoria = categorias.ID
order by productos.nombre;