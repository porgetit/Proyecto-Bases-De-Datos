USE app_db;

-- Insertar datos en la tabla Clientes
INSERT INTO Clientes (NID, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, correo)
VALUES
    ('1234567890', 'Juan', 'Carlos', 'Pérez', 'Gómez', '3001234567', 'juan.perez@email.com'),
    ('9876543210', 'Ana', NULL, 'López', 'Martínez', '3007654321', 'ana.lopez@email.com'),
    ('1122334455', 'Luis', 'Felipe', 'Sánchez', 'Torres', '3009876543', 'luis.sanchez@email.com');

-- Insertar datos en la tabla Usuarios
INSERT INTO Usuarios (NID, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono1, telefono2, correo, direccion, tipo)
VALUES
    ('1234567890', 'Carlos', 'Eduardo', 'Ramírez', 'Hernández', '3101234567', '3107654321', 'carlos.ramirez@email.com', 'Calle Falsa 123', 'admin'),
    ('9876543210', 'Elena', 'María', 'Gutiérrez', 'Pérez', '3109876543', '3108765432', 'elena.gutierrez@email.com', 'Calle Real 456', 'normal'),
    ('1122334455', 'Sofia', 'Isabel', 'Martínez', 'Lopez', '3101234321', NULL, 'sofia.martinez@email.com', 'Calle Azul 789', 'normal');

-- Insertar datos en la tabla Métodos de pago
INSERT INTO Metodos_de_pago (nombre)
VALUES
    ('Efectivo'),
    ('Tarjeta de crédito'),
    ('Nequi'),
    ('Consignación');

-- Insertar datos en la tabla Categorías
INSERT INTO Categorias (nombre) VALUES
    ('Herramientas manuales'),
    ('Herramientas eléctricas'),
    ('Materiales de construcción'),
    ('Pinturas y acabados'),
    ('Plomería'),
    ('Electricidad'),
    ('Jardinería'),
    ('Seguridad industrial');

-- Insertar datos en la tabla Productos
INSERT INTO Productos (nombre, descripcion, id_categoria, precio_compra, porcentaje_ganancia, cantidad_actual, cantidad_minima) VALUES
    ('Martillo', 'Martillo de acero de 500g', 1, 10.50, 30, 100, 10),
    ('Destornillador', 'Destornillador de cabeza plana y cruzada', 1, 4.00, 25, 150, 15),
    ('Taladro eléctrico', 'Taladro con velocidad variable, 600W', 2, 35.00, 40, 50, 5),
    ('Cemento', 'Cemento de alta resistencia para construcción', 3, 5.00, 20, 200, 20),
    ('Bloques de concreto', 'Bloques de concreto para construcción', 3, 2.00, 15, 500, 50),
    ('Pintura acrílica', 'Pintura acrílica de color blanco mate', 4, 8.00, 25, 120, 12),
    ('Pincel', 'Pincel de 2" para pintura', 4, 1.50, 20, 75, 8),
    ('Tubo PVC', 'Tubo PVC para plomería de 2"', 5, 3.00, 18, 150, 15),
    ('Cinta aislante', 'Cinta aislante de 10m', 6, 1.00, 15, 200, 20),
    ('Cable eléctrico', 'Cable eléctrico de 2.5mm para instalaciones', 6, 10.00, 20, 80, 8),
    ('Tijeras de podar', 'Tijeras de podar de 8" para jardinería', 7, 12.00, 30, 60, 6),
    ('Guantes de seguridad', 'Guantes de seguridad para trabajo industrial', 8, 6.00, 25, 100, 10);

-- Insertar datos en la tabla Ventas
INSERT INTO Ventas (codigo_venta, id_producto, id_cliente, id_usuario, id_metodo_pago, fecha, cantidad, notas)
VALUES
    ('20241118-1', 1, '1234567890', '1234567890', 1, '2024-11-18', 10, 'Envío a domicilio'),
    ('20241118-2', 2, '9876543210', '9876543210', 2, '2024-11-18', 5, 'Recogida en tienda'),
    ('20241118-3', 3, '1122334455', '1122334455', 3, '2024-11-18', 2, 'Pago a consignación');

-- Insertar datos en la tabla Proveedores
INSERT INTO Proveedores (RUT, nombre, telefono1, telefono2, correo, direccion)
VALUES
    ('1234567890', 'Proveedor A', '3001234567', '3009876543', 'proveedora@email.com', 'Calle Proveedora 1'),
    ('9876543210', 'Proveedor B', '3007654321', '3006549876', 'proveedorb@email.com', 'Calle Proveedora 2'),
    ('1122334455', 'Proveedor C', '3003214567', NULL, 'proveedorc@email.com', 'Calle Proveedora 3');

-- Insertar datos en la tabla Compras
INSERT INTO Compras (id_proveedor, fecha_orden, total_pagar, fecha_pago)
VALUES
    ('1234567890', '2024-11-10', 500000, '2024-11-20'),
    ('9876543210', '2024-11-12', 100000, '2024-11-25'),
    ('1122334455', '2024-11-15', 150000, '2024-11-22');

-- Insertar datos en la tabla Productos_Compras
INSERT INTO Productos_Compras (id_producto, id_compra)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);

-- Insertar datos en la tabla Vendedores
INSERT INTO Vendedores (NID, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono1, telefono2, correo, id_proveedor)
VALUES
    ('1234567890', 'Carlos', 'Antonio', 'Moreno', 'Gutiérrez', '3101234567', NULL, 'carlos.moreno@email.com', '1234567890'),
    ('9876543210', 'Marta', 'Elena', 'Torres', 'Vega', '3109876543', '3107654321', 'marta.torres@email.com', '9876543210'),
    ('1122334455', 'Luis', 'Felipe', 'Sánchez', 'López', '3103214567', NULL, 'luis.sanchez@email.com', '1122334455');
