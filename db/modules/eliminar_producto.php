<?php 
$page_title = "EliminarProducto";
include_once 'header.php'; 

// Datos de prueba
$product = [
    "nombre" => "Pintura Acrílica",
    "descripcion" => "Pintura de alta calidad para interiores y exteriores.",
    "categoria" => "Pinturas",
    "precio_compra" => "50.00",
    "porcentaje_ganancia" => "30",
    "stock_actual" => "150",
    "stock_minimo" => "20",
];

// Simulación de búsqueda de producto (esto normalmente se haría con una consulta a la base de datos)
$product_found = true; // Cambia esto para simular un producto no encontrado
?>

<main class="container my-5">
    <h1 class="text-danger">Eliminar Producto</h1>
    <p class="text-muted">Ingrese el ID del producto que desea eliminar y confirme la acción.</p>

    <!-- Campo de búsqueda -->
    <form id="searchForm" class="mb-4">
        <div class="mb-3">
            <label for="productID" class="form-label">ID del Producto</label>
            <input type="text" class="form-control" id="productID" placeholder="Ingrese el ID del producto" required>
        </div>
        <button type="submit" class="btn btn-primary">Buscar</button>
    </form>

    <!-- Información del Producto -->
    <?php if ($product_found): ?>
    <div class="card shadow-sm mb-4" id="productDetails">
        <div class="card-body">
            <h5 class="card-title text-primary">Información del Producto</h5>
            <p><strong>Nombre:</strong> <?php echo $product['nombre']; ?></p>
            <p><strong>Descripción:</strong> <?php echo $product['descripcion']; ?></p>
            <p><strong>Categoría:</strong> <?php echo $product['categoria']; ?></p>
            <p><strong>Precio de Compra:</strong> $<?php echo $product['precio_compra']; ?></p>
            <p><strong>Porcentaje de Ganancia:</strong> <?php echo $product['porcentaje_ganancia']; ?>%</p>
            <p><strong>Stock Actual:</strong> <?php echo $product['stock_actual']; ?></p>
            <p><strong>Stock Mínimo:</strong> <?php echo $product['stock_minimo']; ?></p>
        </div>
    </div>

    <!-- Botón de Confirmación -->
    <div class="text-end">
        <button class="btn btn-danger" id="deleteProductBtn">Eliminar Producto</button>
    </div>
    <?php else: ?>
    <div class="alert alert-warning" role="alert" id="noProduct">
        No se encontró ningún producto con el ID especificado.
    </div>
    <?php endif; ?>
</main>

<?php include_once 'footer.php'; ?>

<script>
    // Simular búsqueda y mostrar información del producto
    document.getElementById('searchForm').addEventListener('submit', function (e) {
        e.preventDefault();
        const productID = document.getElementById('productID').value;

        // Aquí agregarías la lógica para buscar el producto en el servidor
        // Por ahora simulamos mostrando directamente los detalles
        if (productID === "123") { // Cambia "123" al ID de prueba
            document.getElementById('productDetails').style.display = 'block';
            document.getElementById('noProduct').style.display = 'none';
        } else {
            document.getElementById('productDetails').style.display = 'none';
            document.getElementById('noProduct').style.display = 'block';
        }
    });

    // Alert de confirmación para eliminar producto
    document.getElementById('deleteProductBtn').addEventListener('click', function () {
        const confirmation = confirm('¿Estás seguro de que deseas eliminar este producto? Esta acción no se puede deshacer.');
        if (confirmation) {
            alert('Producto eliminado con éxito.');
            // Aquí iría la lógica para enviar la solicitud de eliminación al servidor
            window.location.href = 'gestionar_inventario.php';
        }
    });
</script>
