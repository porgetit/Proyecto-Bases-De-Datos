<?php 
$page_title = "RegistroVentas";
include_once 'header.php';
require_once '../config/connection.php';
$conn = new ConexionDB();

// Consultar los productos existentes
$query_productos = "select * from registro_venta_productos;";
$productos = $conn->ejecutarConsulta($query_productos);
$productos_array = [];

while ($producto = $productos->fetch_assoc()) {
    $productos_array[] = $producto;
}

// Consultar los métodos de pago
$query_metodos_pago = "select * from metodos_de_pago order by nombre;";
$metodos_pago = $conn->ejecutarConsulta($query_metodos_pago);
$metodos_pago_array = [];

while ($opcion = $metodos_pago->fetch_assoc()) {
    $metodos_pago_array[] = $opcion;
}

// Consultar toda la información de los clientes
$query_clientes = "SELECT * FROM clientes;";
$result_clientes = $conn->ejecutarConsulta($query_clientes);
$clientes_array = [];

while ($cliente = $result_clientes->fetch_assoc()) {
    $clientes_array[] = $cliente;
}

// Generar el nuevo código de venta
$query_ultimo_codigo = "SELECT MAX(codigo_venta) AS ultimo_codigo FROM ventas;";
$result_ultimo_codigo = $conn->ejecutarConsulta($query_ultimo_codigo);
$fecha_actual = date('Ymd'); // Fecha actual en formato AAAAMMDD
$nuevo_codigo = ''; // Inicializar el nuevo código

if ($result_ultimo_codigo && $result_ultimo_codigo->num_rows > 0) {
    $row = $result_ultimo_codigo->fetch_assoc();
    $ultimo_codigo = $row['ultimo_codigo'];

    if ($ultimo_codigo) {
        // Dividir el último código en fecha y número
        list($fecha, $numero) = explode('-', $ultimo_codigo);

        if ($fecha === $fecha_actual) {
            // Incrementar el número secuencial si la fecha es la misma
            $nuevo_numero = intval($numero) + 1;
        } else {
            // Reiniciar el número si la fecha es diferente
            $nuevo_numero = 1;
        }
    } else {
        // No hay registros previos
        $nuevo_numero = 1;
    }
} else {
    // No hay registros previos
    $nuevo_numero = 1;
}

$nuevo_codigo = $fecha_actual . '-' . $nuevo_numero;
$queries = [];
?>

<main class="container my-5">
    <h1>Registrar Venta</h1>

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
                            <option value="0">Seleccionar producto</option>
                            <?php 
                            foreach ($productos as $producto) {
                                echo "<option value=\"{$producto['id']}\">{$producto['nombre']}</option>";
                            }
                            ?>
                        </select>
                    </td>
                    <td><input type="text" class="form-control" readonly></td>
                    <td><input type="number" class="form-control" oninput="calculateTotal()" readonly></td>
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
                <input type="text" class="form-control" id="clientFirstName" placeholder="Primer Nombre" readonly>
            </div>
            <div class="mb-3">
                <label for="clientSecondName" class="form-label"><strong>Segundo Nombre (opcional):</strong></label>
                <input type="text" class="form-control" id="clientSecondName" placeholder="Segundo Nombre" readonly>
            </div>
            <div class="mb-3">
                <label for="clientLastName" class="form-label"><strong>Primer Apellido:</strong></label>
                <input type="text" class="form-control" id="clientLastName" placeholder="Primer Apellido" readonly>
            </div>
            <div class="mb-3">
                <label for="clientSecondLastName" class="form-label"><strong>Segundo Apellido (opcional):</strong></label>
                <input type="text" class="form-control" id="clientSecondLastName" placeholder="Segundo Apellido" readonly>
            </div>
            <div class="mb-3">
                <label for="clientPhone" class="form-label"><strong>Teléfono:</strong></label>
                <input type="tel" class="form-control" id="clientPhone" placeholder="Teléfono" readonly>
            </div>
            <div class="mb-3">
                <label for="clientEmail" class="form-label"><strong>Correo:</strong></label>
                <input type="email" class="form-control" id="clientEmail" placeholder="Correo" readonly>
            </div>
        </div>
    </div>

    <!-- Método de Pago -->
    <div class="mb-4">
        <label for="paymentMethod" class="form-label">Método de Pago</label>
        <select class="form-select" id="paymentMethod">
            <option value="0">Seleccionar producto</option>
            <?php 
            foreach ($metodos_pago as $opcion) {
                echo "<option value=\"{$opcion['ID']}\">{$opcion['nombre']}</option>";
            }
            ?>
        </select>
    </div>

    <!-- Campo de Notas-->
    <div class="mb-4">
        <label for="saleNotes" class="form-label">Notas de la Venta</label>
        <textarea class="form-control" id="saleNotes" rows="3" placeholder="Indique detalles importantes de la venta como dirección de entrega, datos extra o instrucciones adicionales. Por defecto, el mensaje dirá 'Venta en mostrador.'"></textarea>
    </div>

    <!-- Botón para Enviar (Registrar la Venta) -->
    <button class="btn btn-primary btn-lg" id="registerSaleBtn">Registrar Venta</button>
</main>

<script>
    // Enviar paquete de datos al servidor usando AJAX
    function sendData(dataPack) {
        if (dataPack === "") {
            alert("Por favor, complete todos los campos he intentelo de nuevo.")
            return;
        }

        // Crear solicitud AJAX
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "registro_venta.php", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        // Enviar paquete al servidor
        xhr.send(dataPack);
    }

    // Capturar los datos del formulario
    document.getElementById('registerSaleBtn').addEventListener('click', function() {
        // Captura de productos
        const productos = getProductos();
        // Captura de datos de usuario
        const clientSearchInput = document.getElementById('clientSearch');
        const clienteNID = clientSearchInput.getAttribute('data-nid') || null;
        // Captura del método de pago
        const metodoPagoId = getMetodoPago();
        // Captura de las notas
        const notas = document.getElementById('saleNotes').value || "Venta en mostrador.";

        // console.log(productos);
        // console.log("NID del Cliente:", clientNID);
        // console.log(metodoPagoId);
        // console.log(notas);

        const dataPack = {
            productos: productos,
            cliente: clienteNID,
            metodoPago: metodoPagoId,
            notas: notas
        };

        json_data_pack = JSON.stringify(dataPack, null, 4);

        console.log(json_data_pack);

        sendData(json_data_pack);
    });

    // Captura de productos
    function getProductos() {
        const productTable = document.getElementById("productTable"); // Selecciona la tabla
        const filas = productTable.querySelectorAll("tbody tr"); // Obtén todas las filas del cuerpo de la tabla

        const productos = {}; // Cambiamos a un objeto en lugar de un arreglo

        filas.forEach((fila) => {
            const productId = parseInt(fila.querySelector(".form-select").value);

            if (productId === 0) {
                alert("Por favor, selecciona al menos un producto.");
                return; // Salir de la iteración actual si el producto no es válido
            }

            const cantidad = parseInt(fila.cells[3].querySelector("input").value) || 1;

            // Agregar al objeto productos usando el productId como clave
            productos[productId] = { cantidad };
        });

        if (Object.keys(productos).length === 0) {
            alert("Por favor, selecciona al menos un producto y especifica la cantidad.");
        } else {
            return productos;
        }
    }


    // Captura de método de pago
    function getMetodoPago() {
        const paymentMethodSelect = document.getElementById('paymentMethod');
        const selectedPaymentMethod = paymentMethodSelect.value;

        if (selectedPaymentMethod == 0) {
            alert("Por favor, escoja un método de pago válido.");
        } else {
            return selectedPaymentMethod;
        }
    }

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
                <?php 
                foreach ($productos as $producto) {
                    echo "<option value=\"{$producto['id']}\">{$producto['nombre']}</option>";
                }
                ?>
            </select>
        `;
        categoryCell.innerHTML = '<input type="text" class="form-control" readonly>';
        priceCell.innerHTML = '<input type="number" class="form-control" oninput="calculateTotal()" readonly>';
        amountCell.innerHTML = '<input type="number" class="form-control" oninput="calculateTotal()">';
    });

    // Función para actualizar la información de producto cuando se selecciona uno
    function updateProductInfo(selectElement) {
        const productos = <?php echo json_encode($productos_array); ?>;
        const row = selectElement.closest('tr'); // Obtener la fila
        const product_id = selectElement.value;  // ID del producto seleccionado
        const categoryCell = row.cells[1].querySelector('input'); // Celda de categoría
        const priceCell = row.cells[2].querySelector('input');    // Celda de precio
         
        // Buscar el producto en la estructura 'productos'
        const producto = productos.find(prod => prod.id == product_id);

        if (producto) {
            // Actualizar los valores con datos del producto seleccionado
            categoryCell.value = producto.categoria; // Nombre de la categoría
            priceCell.value = producto.precio_compra * (1 + producto.ganancia / 100); // Precio con ganancia
        } else {
            // Limpiar valores si no se encuentra el producto
            categoryCell.value = '';
            priceCell.value = '';
        }

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

    // Búsqueda de cliente
    document.getElementById('clientSearch').addEventListener('input', function () {
        const clientes = <?php echo json_encode($clientes_array); ?>;
        const searchQuery = this.value.toLowerCase().trim(); // Convertir la búsqueda a minúsculas y eliminar espacios

        if (searchQuery === '') {
            // Si el cuadro está vacío, limpiar todos los campos
            limpiarCampos();
            this.setAttribute('data-nid', ''); // Limpiar el NID almacenado
            return;
        }

        // Filtrar clientes según el nombre o NID
        const resultados = clientes.filter(cliente =>
            cliente.primer_nombre.toLowerCase().includes(searchQuery) ||
            cliente.NID.toLowerCase().includes(searchQuery)
        );

        if (resultados.length > 0) {
            const cliente = resultados[0]; // Mostrar el primer cliente encontrado
            document.getElementById('clientFirstName').value = cliente.primer_nombre;
            document.getElementById('clientSecondName').value = cliente.segundo_nombre || '';
            document.getElementById('clientLastName').value = cliente.primer_apellido;
            document.getElementById('clientSecondLastName').value = cliente.segundo_apellido || '';
            document.getElementById('clientPhone').value = cliente.telefono || '';
            document.getElementById('clientEmail').value = cliente.correo || '';

            // Actualizar el atributo data-nid con el NID del cliente
            this.setAttribute('data-nid', cliente.NID);
        } else {
            // Limpiar los campos si no se encuentra ningún cliente
            limpiarCampos();
            this.setAttribute('data-nid', ''); // Limpiar el NID almacenado
        }
    });

    // Función para limpiar los campos de información del cliente
    function limpiarCampos() {
        document.getElementById('clientFirstName').value = '';
        document.getElementById('clientSecondName').value = '';
        document.getElementById('clientLastName').value = '';
        document.getElementById('clientSecondLastName').value = '';
        document.getElementById('clientPhone').value = '';
        document.getElementById('clientEmail').value = '';
    }

</script>

<?php
include_once 'footer.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['dataPack'])) {
    $data = json_decode($_POST['dataPack'], true);

    // Generar consultas
    foreach ($data['productos'] as $key => $value) {
        $query = "insert into ventas (codigo_venta, id_producto, id_cliente, id_usuario, id_metodo_pago, fecha, cantidad, notas) value ('{$nuevo_codigo}', {$key}, {$data['cliente']}, 1234567890, {$data['metodoPago']}, {getdate()['year'].'-'.getdate()['mon'].'-'.getdate()['mday']}, {$value['cantidad']}, {$data['notas']});";

        $queries[] = $query;
    }

    registrar_venta();
}

function registrar_venta() {
    print_r($queries);
}
?>