<?php 
$page_title = "ModificarProducto";
include_once 'header.php'; 

// Ejemplo de datos existentes
$productos = [
    ["id" => 1, "nombre" => "Pintura Roja", "descripcion" => "Pintura de alta calidad", "categoria" => "Pinturas", "precio_compra" => 50.00, "porcentaje_ganancia" => 30, "stock_actual" => 100, "stock_minimo" => 10],
    ["id" => 2, "nombre" => "Martillo", "descripcion" => "Martillo resistente", "categoria" => "Herramientas", "precio_compra" => 25.00, "porcentaje_ganancia" => 40, "stock_actual" => 50, "stock_minimo" => 5],
];

// Simula la búsqueda de un producto
$producto = isset($_GET['id']) ? array_filter($productos, fn($p) => $p['id'] == $_GET['id'])[0] ?? null : null;
?>

<main class="container my-5">
    <h1>Modificar Producto</h1>
    
    <!-- Buscar producto -->
    <form method="GET" action="modificar_producto.php" class="row g-3 mb-4">
        <div class="col-md-6">
            <label for="id" class="form-label">ID del Producto</label>
            <input type="number" class="form-control" id="id" name="id" placeholder="Ingrese el ID" required>
        </div>
        <div class="col-md-6 d-flex align-items-end">
            <button type="submit" class="btn btn-primary">Buscar Producto</button>
        </div>
    </form>

    <!-- Mostrar datos del producto -->
    <?php if ($producto): ?>
    <form action="guardar_modificaciones.php" method="POST" class="row g-3">
        <input type="hidden" name="id" value="<?php echo $producto['id']; ?>">

        <!-- Nombre -->
        <div class="col-md-6">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" class="form-control" id="nombre" name="nombre" value="<?php echo $producto['nombre']; ?>" required>
        </div>

        <!-- Descripción -->
        <div class="col-md-6">
            <label for="descripcion" class="form-label">Descripción</label>
            <input type="text" class="form-control" id="descripcion" name="descripcion" value="<?php echo $producto['descripcion']; ?>" required>
        </div>

        <!-- Categoría -->
        <div class="col-md-6">
            <label for="categoria" class="form-label">Categoría</label>
            <select class="form-select" id="categoria" name="categoria" required>
                <option value="Pinturas" <?php echo $producto['categoria'] === "Pinturas" ? "selected" : ""; ?>>Pinturas</option>
                <option value="Herramientas" <?php echo $producto['categoria'] === "Herramientas" ? "selected" : ""; ?>>Herramientas</option>
                <option value="Materiales" <?php echo $producto['categoria'] === "Materiales" ? "selected" : ""; ?>>Materiales</option>
            </select>
        </div>

        <!-- Precio de Compra -->
        <div class="col-md-6">
            <label for="precio_compra" class="form-label">Precio de Compra</label>
            <input type="number" class="form-control" id="precio_compra" name="precio_compra" min="0" step="0.01" value="<?php echo $producto['precio_compra']; ?>" required>
        </div>

        <!-- Porcentaje de Ganancia -->
        <div class="col-md-6">
            <label for="porcentaje_ganancia" class="form-label">Porcentaje de Ganancia (%)</label>
            <input type="number" class="form-control" id="porcentaje_ganancia" name="porcentaje_ganancia" min="0" step="1" value="<?php echo $producto['porcentaje_ganancia']; ?>" required>
        </div>

        <!-- Stock Actual -->
        <div class="col-md-6">
            <label for="stock_actual" class="form-label">Stock Actual</label>
            <input type="number" class="form-control" id="stock_actual" name="stock_actual" min="0" value="<?php echo $producto['stock_actual']; ?>" required>
        </div>

        <!-- Stock Mínimo -->
        <div class="col-md-6">
            <label for="stock_minimo" class="form-label">Stock Mínimo</label>
            <input type="number" class="form-control" id="stock_minimo" name="stock_minimo" min="0" value="<?php echo $producto['stock_minimo']; ?>" required>
        </div>

        <!-- Botón para guardar cambios -->
        <div class="col-12">
            <button type="submit" class="btn btn-success">Guardar Cambios</button>
        </div>
    </form>
    <?php elseif (isset($_GET['id'])): ?>
        <p class="text-danger">Producto no encontrado.</p>
    <?php endif; ?>
</main>

<?php include_once 'footer.php'; ?>
