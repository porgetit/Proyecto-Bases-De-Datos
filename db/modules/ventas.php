<?php
$page_title = "Ventas";
include_once 'header.php';
?>

<main class="container my-5">
    <section class="d-flex align-items-center my-4">
        <span class="me-2">Filtrar de:</span>
        <input type="date" class="form-control me-2" id="filterDateFrom" name="filterDateFrom" style="max-width: 200px;">
        <span class="me-2">a:</span>
        <input type="date" class="form-control" id="filterDateTo" name="filterDateTo" style="max-width: 200px;">
        <!-- Aquí puedes agregar botones para realizar acciones como 'Nueva Venta', 'Modificar', etc. -->
    </section>

    <section>
        <table class="table">
            <thead class="table-light">
                <tr>
                    <th># Venta</th>
                    <th>Producto</th>
                    <th>Cantidad</th>
                    <th>Precio Unitario</th>
                    <th>Total Producto</th>
                    <th>Fecha</th>
                    <th>Total Venta</th> <!-- Nueva columna para el total de la venta -->
                </tr>
            </thead>
            <tbody>
                <?php
                // Generar filas de ejemplo para ventas con productos
                $ventas = [
                    // Ejemplo de ventas, cada venta tiene varios productos
                    ['id' => '20241117-1', 'productos' => [
                        ['producto' => 'Producto 1', 'cantidad' => 2, 'precio' => 50],
                        ['producto' => 'Producto 2', 'cantidad' => 1, 'precio' => 100]
                    ], 'fecha' => '2024-11-17'],
                    
                    ['id' => '20241117-2', 'productos' => [
                        ['producto' => 'Producto 3', 'cantidad' => 1, 'precio' => 75]
                    ], 'fecha' => '2024-11-17'],

                    ['id' => '20241117-3', 'productos' => [
                        ['producto' => 'Producto 1', 'cantidad' => 3, 'precio' => 50],
                        ['producto' => 'Producto 2', 'cantidad' => 4, 'precio' => 100]
                    ], 'fecha' => '2024-11-17'],

                    ['id' => '20241117-4', 'productos' => [
                        ['producto' => 'Producto 1', 'cantidad' => 1, 'precio' => 50],
                        ['producto' => 'Producto 2', 'cantidad' => 4, 'precio' => 100]
                    ], 'fecha' => '2024-11-17'],
                    
                    ['id' => '20241117-5', 'productos' => [
                        ['producto' => 'Producto 1', 'cantidad' => 6, 'precio' => 50],
                        ['producto' => 'Producto 2', 'cantidad' => 3, 'precio' => 100],
                        ['producto' => 'Producto 3', 'cantidad' => 1, 'precio' => 75]
                    ], 'fecha' => '2024-11-17'],
                ];

                // Mostrar cada venta
                foreach ($ventas as $venta) {
                    $totalVenta = 0;
                    $productosCount = count($venta['productos']); // Contamos los productos
                    foreach ($venta['productos'] as $index => $producto) {
                        $totalProducto = $producto['cantidad'] * $producto['precio'];
                        $totalVenta += $totalProducto;
                        
                        // Si es el primer producto de la venta, mostramos el número de venta y fecha
                        if ($index == 0) {
                            echo "<tr>
                                <td rowspan='{$productosCount}'>{$venta['id']}</td>
                                <td>{$producto['producto']}</td>
                                <td>{$producto['cantidad']}</td>
                                <td>\${$producto['precio']}</td>
                                <td>\${$totalProducto}</td>
                                <td rowspan='{$productosCount}'>{$venta['fecha']}</td>";
                        } else {
                            // Para los productos siguientes, solo mostramos la información del producto
                            echo "<tr>
                                <td>{$producto['producto']}</td>
                                <td>{$producto['cantidad']}</td>
                                <td>\${$producto['precio']}</td>
                                <td>\${$totalProducto}</td>";
                        }

                        // Si es el último producto, mostramos el total de la venta
                        if ($index == $productosCount - 1) {
                            echo "<td>\${$totalVenta}</td>";
                        }
                        
                        echo "</tr>";
                    }
                }
                ?>
            </tbody>
        </table>
    </section>
</main>

<?php
include_once 'footer.php';
?>
