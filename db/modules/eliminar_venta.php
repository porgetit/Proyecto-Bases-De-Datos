<?php 
$page_title = "EliminarVenta";
include_once 'header.php'; 
?>

<main class="container my-5">
    <h1>Eliminar Venta</h1>

    <!-- Campo para buscar venta por número -->
    <div class="mb-4">
        <label for="saleNumberSearch" class="form-label">Número de Venta</label>
        <input type="text" class="form-control" id="saleNumberSearch" placeholder="Ej. 20231118-1">
    </div>

    <!-- Información de la Venta (Cargada al buscar) -->
    <div class="mb-4" id="saleDetails" style="display: none;">
        <h3>Detalles de la Venta</h3>
        <p><strong>Número de Venta:</strong> <span id="saleNumber">20231118-1</span></p>
        <p><strong>Fecha de la Venta:</strong> <span id="saleDate">2023-11-18</span></p>
        <p><strong>Cliente:</strong> <span id="clientName">Juan Pérez</span></p>
        <p><strong>Total:</strong> $<span id="totalAmount">150.00</span></p>
        <p><strong>Productos:</strong></p>
        <ul id="productList">
            <li>Producto 1 - $50.00 x 2</li>
            <li>Producto 2 - $30.00 x 1</li>
        </ul>
    </div>

    <!-- Botón para eliminar la venta -->
    <button class="btn btn-danger" id="deleteSaleBtn" style="display: none;">Eliminar Registro</button>
</main>

<?php include_once 'footer.php'; ?>

<script>
    // Datos de ejemplo (aquí podrías integrar con una base de datos real)
    const salesData = {
        "20231118-1": {
            number: "20231118-1",
            date: "2023-11-18",
            client: "Juan Pérez",
            total: 150.00,
            products: [
                {name: "Producto 1", price: 50.00, quantity: 2},
                {name: "Producto 2", price: 30.00, quantity: 1}
            ]
        },
        "20231119-2": {
            number: "20231119-2",
            date: "2023-11-19",
            client: "María López",
            total: 200.00,
            products: [
                {name: "Producto 3", price: 70.00, quantity: 2},
                {name: "Producto 4", price: 60.00, quantity: 1}
            ]
        },
        "20231120-3": {
            number: "20231120-3",
            date: "2023-11-20",
            client: "Carlos Sánchez",
            total: 180.00,
            products: [
                {name: "Producto 5", price: 80.00, quantity: 1},
                {name: "Producto 6", price: 50.00, quantity: 2}
            ]
        }
    };

    // Función para buscar la venta por número
    document.getElementById('saleNumberSearch').addEventListener('input', function() {
        const saleNumber = this.value;

        // Verificar si la venta existe en los datos de ejemplo
        if (salesData[saleNumber]) {
            // Mostrar los detalles de la venta
            const sale = salesData[saleNumber];
            document.getElementById('saleNumber').textContent = sale.number;
            document.getElementById('saleDate').textContent = sale.date;
            document.getElementById('clientName').textContent = sale.client;
            document.getElementById('totalAmount').textContent = sale.total.toFixed(2);

            // Mostrar productos
            const productList = document.getElementById('productList');
            productList.innerHTML = ''; // Limpiar lista de productos
            sale.products.forEach(product => {
                const listItem = document.createElement('li');
                listItem.textContent = `${product.name} - $${product.price.toFixed(2)} x ${product.quantity}`;
                productList.appendChild(listItem);
            });

            // Mostrar los detalles y el botón de eliminación
            document.getElementById('saleDetails').style.display = 'block';
            document.getElementById('deleteSaleBtn').style.display = 'inline-block';
        } else {
            // Si no existe la venta, ocultar detalles y botón
            document.getElementById('saleDetails').style.display = 'none';
            document.getElementById('deleteSaleBtn').style.display = 'none';
        }
    });

    // Función para eliminar la venta
    document.getElementById('deleteSaleBtn').addEventListener('click', function() {
        const saleNumber = document.getElementById('saleNumber').textContent;

        // Confirmar eliminación
        if (confirm(`¿Estás seguro de que deseas eliminar la venta ${saleNumber}? Esta acción no se puede deshacer.`)) {
            // Aquí iría el código para eliminar la venta en la base de datos

            // Mostrar alerta de eliminación exitosa
            alert(`La venta ${saleNumber} ha sido eliminada correctamente.`);

            // Limpiar los detalles y esconder los elementos
            document.getElementById('saleNumberSearch').value = '';
            document.getElementById('saleDetails').style.display = 'none';
            document.getElementById('deleteSaleBtn').style.display = 'none';
        }
    });
</script>
<?php
include_once 'footer.php';
?>