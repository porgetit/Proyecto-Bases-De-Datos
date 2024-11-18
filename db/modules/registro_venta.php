<?php 
$page_title = "RegistroVentas";
include_once 'header.php'; 
?>

<main class="container my-5">
    <h1>Registrar Venta</h1>

    <!-- Número de Venta (Generado automáticamente) -->
    <div class="mb-4">
        <label for="saleNumber" class="form-label">Número de Venta</label>
        <input type="text" class="form-control" id="saleNumber" value="<?php echo date('Ymd') . '-1'; ?>" readonly>
    </div>

    <!-- Listado de Productos -->
    <div class="mb-4">
        <label for="products" class="form-label">Productos</label>
        <table class="table table-bordered" id="productTable">
            <thead>
                <tr>
                    <th>Producto</th>
                    <th>Categoría</th>
                    <th>Precio</th>
                    <th>Cantidad</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <select class="form-select" onchange="updateProductInfo(this)">
                            <option value="">Seleccionar producto</option>
                            <option value="Producto 1">Producto 1</option>
                            <option value="Producto 2">Producto 2</option>
                            <option value="Producto 3">Producto 3</option>
                        </select>
                    </td>
                    <td><input type="text" class="form-control" readonly></td>
                    <td><input type="number" class="form-control" oninput="calculateTotal()"></td>
                    <td><input type="number" class="form-control" oninput="calculateTotal()"></td>
                </tr>
            </tbody>
        </table>
        <div class="d-flex justify-content-between align-items-center">
            <button class="btn btn-success" id="addProductBtn">Agregar</button>
            <div>
                <span>Total: </span>
                <span id="totalValue">0.00</span>
            </div>
        </div>
    </div>



    <!-- Información del Cliente -->
    <div class="mb-4">
        <label for="clientSearch" class="form-label">Buscar Cliente</label>
        <input type="text" class="form-control" id="clientSearch" placeholder="Nombre o número de identidad">
        
        <div id="clientInfo" class="mt-3">
            <div class="mb-3">
                <label for="clientFirstName" class="form-label"><strong>Primer Nombre:</strong></label>
                <input type="text" class="form-control" id="clientFirstName" placeholder="Primer Nombre">
            </div>
            <div class="mb-3">
                <label for="clientSecondName" class="form-label"><strong>Segundo Nombre (opcional):</strong></label>
                <input type="text" class="form-control" id="clientSecondName" placeholder="Segundo Nombre">
            </div>
            <div class="mb-3">
                <label for="clientLastName" class="form-label"><strong>Primer Apellido:</strong></label>
                <input type="text" class="form-control" id="clientLastName" placeholder="Primer Apellido">
            </div>
            <div class="mb-3">
                <label for="clientSecondLastName" class="form-label"><strong>Segundo Apellido (opcional):</strong></label>
                <input type="text" class="form-control" id="clientSecondLastName" placeholder="Segundo Apellido">
            </div>
            <div class="mb-3">
                <label for="clientPhone" class="form-label"><strong>Teléfono:</strong></label>
                <input type="tel" class="form-control" id="clientPhone" placeholder="Teléfono">
            </div>
            <div class="mb-3">
                <label for="clientEmail" class="form-label"><strong>Correo:</strong></label>
                <input type="email" class="form-control" id="clientEmail" placeholder="Correo">
            </div>
        </div>
    </div>

    <!-- Método de Pago -->
    <div class="mb-4">
        <label for="paymentMethod" class="form-label">Método de Pago</label>
        <select class="form-select" id="paymentMethod">
            <option value="">Seleccionar método</option>
            <option value="Efectivo">Efectivo</option>
            <option value="Tarjeta">Tarjeta</option>
            <option value="Transferencia">Transferencia</option>
        </select>
    </div>

    <!-- Campo de Notas (Nuevo) -->
    <div class="mb-4">
        <label for="saleNotes" class="form-label">Notas de la Venta</label>
        <textarea class="form-control" id="saleNotes" rows="3" placeholder="Indique detalles importantes de la venta como dirección de entrega, datos extra o instrucciones adicionales."></textarea>
    </div>

    <!-- Botón para Enviar (Registrar la Venta) -->
    <button class="btn btn-primary btn-lg" id="registerSaleBtn">Registrar Venta</button>
</main>

<?php include_once 'footer.php'; ?>

<script>
    // Lógica para agregar nuevas filas de productos
    document.getElementById('addProductBtn').addEventListener('click', function() {
        const productTable = document.getElementById('productTable').getElementsByTagName('tbody')[0];
        const newRow = productTable.insertRow();
        
        const productCell = newRow.insertCell(0);
        const categoryCell = newRow.insertCell(1);
        const priceCell = newRow.insertCell(2);
        const amountCell = newRow.insertCell(3);

        productCell.innerHTML = `
            <select class="form-select" onchange="updateProductInfo(this)">
                <option value="">Seleccionar producto</option>
                <option value="Producto 1">Producto 1</option>
                <option value="Producto 2">Producto 2</option>
                <option value="Producto 3">Producto 3</option>
            </select>
        `;
        categoryCell.innerHTML = '<input type="text" class="form-control" readonly>';
        priceCell.innerHTML = '<input type="number" class="form-control" oninput="calculateTotal()">';
        amountCell.innerHTML = '<input type="number" class="form-control" oninput="calculateTotal()">';
    });

    // Función para actualizar la información de producto cuando se selecciona uno
    function updateProductInfo(selectElement) {
        const row = selectElement.closest('tr'); // Obtener la fila
        const product = selectElement.value;
        const categoryCell = row.cells[1];
        const priceCell = row.cells[2].querySelector('input');
        
        // Definir los valores predeterminados para cada producto
        let category = '';
        let price = 0;

        if (product === 'Producto 1') {
            category = 'Categoría 1';
            price = 10; // Precio en USD o cualquier unidad
        } else if (product === 'Producto 2') {
            category = 'Categoría 2';
            price = 20;
        } else if (product === 'Producto 3') {
            category = 'Categoría 3';
            price = 30;
        }

        // Actualizar los valores de categoría y precio
        categoryCell.querySelector('input').value = category;
        priceCell.value = price;

        // Actualizar el total inmediatamente
        calculateTotal();
    }

    // Función para calcular el total acumulado
    function calculateTotal() {
        let total = 0;
        const rows = document.querySelectorAll('#productTable tbody tr');

        rows.forEach(row => {
            const price = parseFloat(row.querySelector('td:nth-child(3) input').value) || 0;
            const quantity = parseInt(row.querySelector('td:nth-child(4) input').value) || 0;
            total += price * quantity;
        });

        // Actualizar el total en el DOM
        document.getElementById('totalValue').textContent = total.toFixed(2);
    }


    // Lógica para buscar y mostrar la información del cliente (Simulación por ahora)
    document.getElementById('clientSearch').addEventListener('input', function () {
        const clientSearch = this.value.trim();

        // Simulando búsqueda de cliente
        if (clientSearch === 'Cliente 1') {
            document.getElementById('clientFirstName').value = 'Juan';
            document.getElementById('clientSecondName').value = 'Carlos';
            document.getElementById('clientLastName').value = 'Pérez';
            document.getElementById('clientSecondLastName').value = 'Gómez';
            document.getElementById('clientPhone').value = '123456789';
            document.getElementById('clientEmail').value = 'juan.perez@example.com';
            document.getElementById('clientInfo').style.display = 'block';
        } else {
            // Limpiar campos y ocultar la información si no se encuentra un cliente
            document.getElementById('clientFirstName').value = '';
            document.getElementById('clientSecondName').value = '';
            document.getElementById('clientLastName').value = '';
            document.getElementById('clientSecondLastName').value = '';
            document.getElementById('clientPhone').value = '';
            document.getElementById('clientEmail').value = '';
            document.getElementById('clientInfo').style.display = 'none';
        }
    });

    // Lógica para registrar la venta (Por ahora solo muestra un mensaje)
    document.getElementById('registerSaleBtn').addEventListener('click', function() {
        alert('Venta registrada correctamente');
    });
</script>
<?php
include_once 'footer.php';
?>