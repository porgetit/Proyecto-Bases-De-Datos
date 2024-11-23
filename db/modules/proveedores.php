<?php 
$page_title = "Proveedores";
include_once 'header.php';

require_once '../config/connection.php';

// Consulta a la vista para obtener la información de proveedores y vendedores
$conn = new ConexionDB();
$query = "SELECT * FROM proveedores_con_vendedores";
$result = $conn->ejecutarConsulta($query);

$proveedores = [];
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $rut = $row['rut'];

        // Inicializamos el proveedor si no existe
        if (!isset($proveedores[$rut])) {
            $proveedores[$rut] = [
                "nombre" => $row['nombre_proveedor'],
                "telefono_1" => $row['proveedor_telefono_1'],
                "telefono_2" => $row['proveedor_telefono_2'],
                "correo" => $row['proveedor_correo'],
                "direccion" => $row['direccion'],
                "vendedores" => [] // Inicializamos el subarreglo
            ];
        }

        // Agregar cada vendedor al subarreglo de "vendedores"
        if (!empty($row['NID'])) { // FIXME Solo se muestra el último vendedor procesado
            $nuevo_vendedor = [
                "nid" => $row['NID'],
                "primer_nombre" => $row['primer_nombre'],
                "segundo_nombre" => $row['segundo_nombre'],
                "primer_apellido" => $row['primer_apellido'],
                "segundo_apellido" => $row['segundo_apellido'],
                "telefono_1" => $row['telefono1'],
                "telefono_2" => $row['telefono2'],
                "correo" => $row['vendedor_correo']
            ];

            // Usamos array_push para evitar sobrescribir
            array_push($proveedores[$rut]['vendedores'], $nuevo_vendedor);
        }
    }
}
?>

<main class="container my-5">
    <h1 class="text-primary">Gestión de Proveedores</h1>
    <p class="text-muted">Lista de todos los proveedores con sus vendedores asociados.</p>

    <!-- Bloques de Proveedores -->
    <?php foreach ($proveedores as $rut => $proveedor): ?>
        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <h5 class="card-title text-success"><?php echo htmlspecialchars($proveedor['nombre']); ?></h5>
                <p><strong>RUT:</strong> <?php echo htmlspecialchars($rut); ?></p>
                <p><strong>Teléfono 1:</strong> <?php echo htmlspecialchars($proveedor['telefono_1']); ?></p>
                <p><strong>Teléfono 2:</strong> <?php echo $proveedor['telefono_2'] ?: 'N/A'; ?></p>
                <p><strong>Correo:</strong> <?php echo htmlspecialchars($proveedor['correo']); ?></p>
                <p><strong>Dirección:</strong> <?php echo htmlspecialchars($proveedor['direccion']); ?></p>

                <!-- Vendedores asociados -->
                <?php if (!empty($proveedor['vendedores'])): ?>
                    <div class="mt-3">
                        <h6 class="text-secondary">Vendedores Asociados:</h6>
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>NID</th>
                                        <th>Primer Nombre</th>
                                        <th>Segundo Nombre</th>
                                        <th>Primer Apellido</th>
                                        <th>Segundo Apellido</th>
                                        <th>Teléfono 1</th>
                                        <th>Teléfono 2</th>
                                        <th>Correo</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($proveedor['vendedores'] as $vendedor): ?>
                                        <tr>
                                            <td><?php echo htmlspecialchars($vendedor['nid']); ?></td>
                                            <td><?php echo htmlspecialchars($vendedor['primer_nombre']); ?></td>
                                            <td><?php echo htmlspecialchars($vendedor['segundo_nombre']); ?></td>
                                            <td><?php echo htmlspecialchars($vendedor['primer_apellido']); ?></td>
                                            <td><?php echo htmlspecialchars($vendedor['segundo_apellido']); ?></td>
                                            <td><?php echo htmlspecialchars($vendedor['telefono_1']); ?></td>
                                            <td><?php echo $vendedor['telefono_2'] ?: 'N/A'; ?></td>
                                            <td><?php echo htmlspecialchars($vendedor['correo']); ?></td>
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                <?php else: ?>
                    <p class="text-muted">No hay vendedores asociados.</p>
                <?php endif; ?>
            </div>
        </div>
    <?php endforeach; ?>
</main>

<?php include_once 'footer.php'; ?>
