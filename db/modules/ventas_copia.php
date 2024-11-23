<?php
// Establecer conexión a la base de datos
require_once '../config/connection.php';

// Capturar las fechas del filtro si están presentes
$fechaDesde = isset($_GET['filterDateFrom']) ? $_GET['filterDateFrom'] : null;
$fechaHasta = isset($_GET['filterDateTo']) ? $_GET['filterDateTo'] : null;

// Construir la consulta base
$query = "SELECT * FROM ventas_view";

// Agregar filtros de fecha si están definidos
if ($fechaDesde || $fechaHasta) {
    $query .= " WHERE";
    if ($fechaDesde) {
        $query .= " fecha_registro >= '$fechaDesde'";
    }
    if ($fechaHasta) {
        $query .= ($fechaDesde ? " AND" : "") . " fecha_registro <= '$fechaHasta'";
    }
}

$query .= " ORDER BY codigo, id;";

// Ejecutar la consulta
$conn = new ConexionDB();
$resultado = $conn->ejecutarConsulta($query);
?>

<?php
$page_title = "Ventas";
include_once 'header.php';
?>

<main class="container my-5">
    <h1>Ventas</h1>
    <section class="d-flex align-items-center my-4">
        <span class="me-2">Filtrar de:</span>
        <input type="date" class="form-control me-2" id="filterDateFrom" name="filterDateFrom" style="max-width: 200px;" value="<?php echo $fechaDesde; ?>">
        <span class="me-2">a:</span>
        <input type="date" class="form-control" id="filterDateTo" name="filterDateTo" style="max-width: 200px;" value="<?php echo $fechaHasta; ?>">
    </section>

    <section>
        <table class="table mt-4">
            <thead class="table-light">
                <tr>
                    <th scope="col"># Venta</th>
                    <th scope="col">Producto</th>
                    <th scope="col">Cantidad</th>
                    <th scope="col">Precio</th>
                    <th scope="col">Total del Producto</th>
                    <th scope="col">Fecha</th>
                    <th scope="col">Cliente</th>
                    <th scope="col">Vendedor</th>
                    <th scope="col">Método de Pago</th>
                    <th scope="col">Total de la Venta</th>
                    <th scope="col">Notas</th>
                </tr>
            </thead>
            <tbody>
                <?php
                    $codigoActual = null;
                    $totalVenta = 0;
                    $granTotal = 0;
                    $rows = [];
                    $isFirstRow = true;

                    // Procesa cada fila de resultados
                    while ($venta = $resultado->fetch_assoc()) {
                        // Verifica si cambia el código de venta
                        if ($codigoActual !== $venta['codigo']) {
                            // Si hay un grupo previo, agrega el total en la última fila del grupo
                            if ($codigoActual !== null) {
                                $rows[count($rows) - 1]['total_venta'] = $totalVenta;
                                $granTotal += $totalVenta;
                            }

                            // Reinicia variables para el nuevo grupo
                            $codigoActual = $venta['codigo'];
                            $totalVenta = 0;
                            $isFirstRow = true; // Marca el inicio de un nuevo grupo
                        }

                        // Calcula el total del producto
                        $totalProducto = $venta['cantidad'] * $venta['producto_precio'] * (1 + $venta['producto_ganancia'] / 100);
                        $totalVenta += $totalProducto;

                        // Almacena la fila en un array temporal
                        $rows[] = [
                            'codigo' => $isFirstRow ? $venta['codigo'] : null, // Solo para la primera fila
                            'producto' => $venta['producto'],
                            'cantidad' => $venta['cantidad'],
                            'producto_precio' => $venta['producto_precio'] * (1 + $venta['producto_ganancia'] / 100),
                            'total_producto' => $totalProducto,
                            'fecha_registro' => $venta['fecha_registro'],
                            'cliente' => trim("{$venta['cliente_primer_nombre']} {$venta['cliente_segundo_nombre']} {$venta['cliente_primer_apellido']} {$venta['cliente_segundo_apellido']}"),
                            'vendedor' => trim("{$venta['usuario_primer_nombre']} {$venta['usuario_segundo_nombre']} {$venta['usuario_primer_apellido']} {$venta['usuario_segundo_apellido']}"),
                            'metodo_de_pago' => $venta['metodo_de_pago'],
                            'notas' => $isFirstRow ? $venta['notas'] : null, // Solo para la primera fila
                            'total_venta' => null // Se asignará en la última fila del grupo
                        ];

                        $isFirstRow = false; // Marca las filas posteriores como no principales
                    }

                    // Asigna el total a la última fila del último grupo
                    if (!empty($rows)) {
                        $rows[count($rows) - 1]['total_venta'] = $totalVenta;
                        $granTotal += $totalVenta;
                    }

                    // Muestra las filas en la tabla
                    foreach ($rows as $row) {
                        echo "<tr>
                                <td>" . ($row['codigo'] ?? '') . "</td>
                                <td>{$row['producto']}</td>
                                <td>{$row['cantidad']}</td>
                                <td>\${$row['producto_precio']}</td>
                                <td>\${$row['total_producto']}</td>
                                <td>{$row['fecha_registro']}</td>
                                <td>{$row['cliente']}</td>
                                <td>{$row['vendedor']}</td>
                                <td>{$row['metodo_de_pago']}</td>
                                <td>" . ($row['total_venta'] !== null ? "\${$row['total_venta']}" : '') . "</td>
                                <td>" . ($row['notas'] ?? '') . "</td>
                            </tr>";
                    }
                ?>
            </tbody>
            <tfoot>
                <tr class="table-light">
                    <td colspan="9"><strong>Total General</strong></td>
                    <td colspan="2"><strong>$<?php echo number_format($granTotal, 2); ?></strong></td>
                </tr>
            </tfoot>
        </table>
    </section>
</main>

<?php
include_once 'footer.php';
?>

<script>
    document.getElementById('filterDateFrom').addEventListener('change', applyFilter);
    document.getElementById('filterDateTo').addEventListener('change', applyFilter);

    function applyFilter() {
        const filterDateFrom = document.getElementById('filterDateFrom').value;
        const filterDateTo = document.getElementById('filterDateTo').value;

        const params = new URLSearchParams(window.location.search);
        if (filterDateFrom) params.set('filterDateFrom', filterDateFrom);
        if (filterDateTo) params.set('filterDateTo', filterDateTo);

        window.location.search = params.toString();
    }
</script>
