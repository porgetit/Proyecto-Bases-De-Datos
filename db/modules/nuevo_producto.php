<?php 
$page_title = "AgregarProducto";
include_once 'header.php'; 
?>

<main class="container my-5">
    <h1>Agregar Nuevo Producto</h1>
    <form action="guardar_producto.php" method="POST" class="row g-3">
        <!-- Nombre -->
        <div class="col-md-6">
            <label for="nombre" class="form-label">Nombre</label>
            <input type="text" class="form-control" id="nombre" name="nombre" required>
        </div>

        <!-- Descripción -->
        <div class="col-md-6">
            <label for="descripcion" class="form-label">Descripción</label>
            <input type="text" class="form-control" id="descripcion" name="descripcion" required>
        </div>

        <!-- Categoría -->
        <div class="col-md-6">
            <label for="categoria" class="form-label">Categoría</label>
            <select class="form-select" id="categoria" name="categoria" required>
                <option value="" disabled selected>Seleccione una categoría</option>
                <option value="Pinturas">Pinturas</option>
                <option value="Herramientas">Herramientas</option>
                <option value="Materiales">Materiales</option>
            </select>
        </div>

        <!-- Precio de Compra -->
        <div class="col-md-6">
            <label for="precio_compra" class="form-label">Precio de Compra</label>
            <input type="number" class="form-control" id="precio_compra" name="precio_compra" min="0" step="0.01" required>
        </div>

        <!-- Porcentaje de Ganancia -->
        <div class="col-md-6">
            <label for="porcentaje_ganancia" class="form-label">Porcentaje de Ganancia (%)</label>
            <input type="number" class="form-control" id="porcentaje_ganancia" name="porcentaje_ganancia" min="0" step="1" required>
        </div>

        <!-- Stock Actual -->
        <div class="col-md-6">
            <label for="stock_actual" class="form-label">Stock Actual</label>
            <input type="number" class="form-control" id="stock_actual" name="stock_actual" min="0" required>
        </div>

        <!-- Stock Mínimo -->
        <div class="col-md-6">
            <label for="stock_minimo" class="form-label">Stock Mínimo</label>
            <input type="number" class="form-control" id="stock_minimo" name="stock_minimo" min="0" required>
        </div>

        <!-- Botón para enviar -->
        <div class="col-12">
            <button type="submit" class="btn btn-primary">Agregar Producto</button>
        </div>
    </form>
</main>

<?php include_once 'footer.php'; ?>
