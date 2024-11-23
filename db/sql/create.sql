
-- TODO Es interesante la idea de simplificar la estructura al eliminar la entidad de compras, esto también eliminaría la necesidad de tener una tabla que relaciona los productos con las compras y haría que se tuviera que relacionar directamente los productos con los proveedores. Quizá con una tabla producto-proveedor para manejar adecuadamente los casos en que se tiene varios proveedores que surten varios productos y varios productos surtidos por varios proveedores. Muchos-muchos. Nota, no es de considerar la redución en la cantidad de entidades más que como una modificación en los requerimientos del proyecto definidos por mí puesto que la restricción de mínimo 5 tablas se cumple de sobra. Además es de tener en cuenta que de realizar esta modificación será necesario ajustar los datos de población inicial y todos los procedimientos afectados.

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS app_db;
USE app_db;

-- Crear la tabla Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    NID VARCHAR(20) PRIMARY KEY,
    primer_nombre VARCHAR(100) NOT NULL,
    segundo_nombre VARCHAR(100) DEFAULT 'Desconocido',
    primer_apellido VARCHAR(100) NOT NULL,
    segundo_apellido VARCHAR(100) DEFAULT 'Desconocido',
    telefono VARCHAR(20) DEFAULT NULL,
    correo VARCHAR(100) DEFAULT NULL
);

-- Crear la tabla Usuarios
CREATE TABLE IF NOT EXISTS Usuarios (
    NID VARCHAR(20) PRIMARY KEY,
    primer_nombre VARCHAR(100) NOT NULL,
    segundo_nombre VARCHAR(100) DEFAULT 'Desconocido',
    primer_apellido VARCHAR(100) NOT NULL,
    segundo_apellido VARCHAR(100) DEFAULT 'Desconocido',
    telefono1 VARCHAR(20) NOT NULL,
    telefono2 VARCHAR(20) DEFAULT NULL,
    correo VARCHAR(100) NOT NULL,
    direccion TEXT DEFAULT NULL,
    tipo ENUM('admin', 'normal') NOT NULL
);

-- Crear la tabla Métodos de pago
CREATE TABLE IF NOT EXISTS Metodos_de_pago (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Crear la tabla Categorías
CREATE TABLE IF NOT EXISTS Categorias (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Crear la tabla Productos
CREATE TABLE IF NOT EXISTS Productos (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT DEFAULT NULL,
    id_categoria INT,
    precio_compra DECIMAL(10,2) NOT NULL,
    porcentaje_ganancia DECIMAL(5,2) NOT NULL,
    cantidad_actual INT NOT NULL,
    cantidad_minima INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Categorias(ID)
);

-- Crear la tabla Ventas
CREATE TABLE IF NOT EXISTS Ventas (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    codigo_venta VARCHAR(20) NOT NULL,
    id_producto INT,
    id_cliente VARCHAR(20) DEFAULT NULL,
    id_usuario VARCHAR(20) NOT NULL,
    id_metodo_pago INT NOT NULL,
    fecha DATE NOT NULL,    
    cantidad int(10) UNSIGNED NOT NULL,
    notas TEXT DEFAULT NULL,
    FOREIGN KEY (id_producto) REFERENCES Productos(ID),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(NID),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(NID),
    FOREIGN KEY (id_metodo_pago) REFERENCES Metodos_de_pago(ID)
);

-- Crear la tabla Proveedores
CREATE TABLE IF NOT EXISTS Proveedores (
    RUT VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono1 VARCHAR(20) NOT NULL,
    telefono2 VARCHAR(20) DEFAULT NULL,
    correo VARCHAR(100) DEFAULT NULL,
    direccion TEXT DEFAULT NULL
);

-- Crear la tabla Compras
CREATE TABLE IF NOT EXISTS Compras (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor VARCHAR(20) NOT NULL,
    fecha_orden DATE NOT NULL,
    total_pagar DECIMAL(10,2) NOT NULL,
    fecha_pago DATE NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(RUT)
);

-- Crear la tabla Productos-Compras
CREATE TABLE IF NOT EXISTS Productos_Compras (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    id_compra INT,
    FOREIGN KEY (id_producto) REFERENCES Productos(ID),
    FOREIGN KEY (id_compra) REFERENCES Compras(ID)
);

-- Crear la tabla Vendedores
CREATE TABLE IF NOT EXISTS Vendedores (
    NID VARCHAR(20) PRIMARY KEY,
    primer_nombre VARCHAR(100) NOT NULL,
    segundo_nombre VARCHAR(100) DEFAULT 'Desconocido',
    primer_apellido VARCHAR(100) NOT NULL,
    segundo_apellido VARCHAR(100) DEFAULT 'Desconocido',
    telefono1 VARCHAR(20) NOT NULL,
    telefono2 VARCHAR(20) DEFAULT NULL,
    correo VARCHAR(100) DEFAULT NULL,
    id_proveedor VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(RUT)
);
