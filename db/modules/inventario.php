<?php 
$page_title = "Inventario";
include_once 'header.php';

require_once '../config/connection.php';

$query = "select * from inventario;";
$conn = new ConexionDB();
$inventory_data = $conn->ejecutarConsulta($query);

// Datos de prueba para el inventario
// $inventory_data = [
//     [
//         'id' => 1,
//         'nombre' => 'Pintura Acrílica',
//         'descripcion' => 'Pintura a base de agua, colores variados.',
//         'categoria' => 'Pinturas',
//         'precio_compra' => 20.00,
//         'porcentaje_ganancia' => 30,
//         'stock_actual' => 50,
//         'stock_minimo' => 10
//     ],
//     [
//         'id' => 2,
//         'nombre' => 'Brocha de 2 pulgadas',
//         'descripcion' => 'Brocha de cerda sintética para acabados finos.',
//         'categoria' => 'Herramientas',
//         'precio_compra' => 5.00,
//         'porcentaje_ganancia' => 50,
//         'stock_actual' => 30,
//         'stock_minimo' => 5
//     ],
//     [
//         'id' => 3,
//         'nombre' => 'Esmalte Sintético',
//         'descripcion' => 'Pintura de alto brillo resistente al agua.',
//         'categoria' => 'Pinturas',
//         'precio_compra' => 25.00,
//         'porcentaje_ganancia' => 40,
//         'stock_actual' => 20,
//         'stock_minimo' => 5
//     ]
// ];
?>

<main class="container my-5">
    <h1>Inventario de Productos</h1>
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Categoría</th>
                    <th>Precio de Compra</th>
                    <th>% Ganancia</th>
                    <th>Precio de Venta</th>
                    <th>Stock Actual</th>
                    <th>Stock Mínimo</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($inventory_data as $product): ?>
                <tr>
                    <td><?php echo $product['id']; ?></td>
                    <td><?php echo $product['nombre']; ?></td>
                    <td><?php echo $product['descripcion']; ?></td>
                    <td><?php echo $product['categoria']; ?></td>
                    <td>$<?php echo number_format($product['precio_compra'], 2); ?></td>
                    <td><?php echo $product['ganancia']; ?>%</td>
                    <td><?php echo number_format($product['precio_compra'] * (1 + $product['ganancia'] / 100), 2) ?></td>
                    <td><?php echo $product['stock_actual']; ?></td>
                    <td><?php echo $product['stock_minimo']; ?></td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</main>

<?php include_once 'footer.php'; ?>
