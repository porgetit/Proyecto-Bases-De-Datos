<?php 
$page_title = "Proveedores";
include_once 'header.php'; 

// Información de prueba
$empresa = [
    "rut" => "12345678-9",
    "nombre" => "Distribuciones La Excelencia S.A.",
    "telefono_1" => "3001234567",
    "telefono_2" => "3017654321",
    "correo" => "contacto@excelencia.com",
    "direccion" => "Calle 45 #23-89, Bogotá"
];

$vendedores = [
    [
        "nid" => "1023456789",
        "primer_nombre" => "Carlos",
        "segundo_nombre" => "Alberto",
        "primer_apellido" => "Pérez",
        "segundo_apellido" => "Gómez",
        "telefono_1" => "3104567890",
        "telefono_2" => "3210987654",
        "correo" => "carlos.perez@excelencia.com"
    ],
    [
        "nid" => "1034567890",
        "primer_nombre" => "María",
        "segundo_nombre" => "Luisa",
        "primer_apellido" => "Ramírez",
        "segundo_apellido" => "Torres",
        "telefono_1" => "3112345678",
        "telefono_2" => "",
        "correo" => "maria.ramirez@excelencia.com"
    ]
];
?>

<main class="container my-5">
    <h1 class="text-primary">Gestión de Proveedores</h1>
    <p class="text-muted">Utilice el cuadro de búsqueda para encontrar proveedores por producto o empresa.</p>

    <!-- Cuadro de búsqueda -->
    <form id="searchForm" class="mb-4">
        <div class="mb-3">
            <label for="searchInput" class="form-label">Buscar</label>
            <input type="text" class="form-control" id="searchInput" placeholder="Ingrese el nombre del producto o empresa" required>
        </div>
        <button type="submit" class="btn btn-primary">Buscar</button>
    </form>

    <!-- Información de la Empresa -->
    <div class="card shadow-sm mb-4" id="empresaInfo">
        <div class="card-body">
            <h5 class="card-title text-success">Información de la Empresa</h5>
            <p><strong>RUT:</strong> <?php echo $empresa['rut']; ?></p>
            <p><strong>Nombre:</strong> <?php echo $empresa['nombre']; ?></p>
            <p><strong>Teléfono 1:</strong> <?php echo $empresa['telefono_1']; ?></p>
            <p><strong>Teléfono 2:</strong> <?php echo $empresa['telefono_2']; ?></p>
            <p><strong>Correo:</strong> <?php echo $empresa['correo']; ?></p>
            <p><strong>Dirección:</strong> <?php echo $empresa['direccion']; ?></p>
        </div>
    </div>

    <!-- Lista de Vendedores -->
    <div class="card shadow-sm" id="vendedoresInfo">
        <div class="card-body">
            <h5 class="card-title text-secondary">Vendedores Asociados</h5>
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
                        <?php foreach ($vendedores as $vendedor): ?>
                        <tr>
                            <td><?php echo $vendedor['nid']; ?></td>
                            <td><?php echo $vendedor['primer_nombre']; ?></td>
                            <td><?php echo $vendedor['segundo_nombre']; ?></td>
                            <td><?php echo $vendedor['primer_apellido']; ?></td>
                            <td><?php echo $vendedor['segundo_apellido']; ?></td>
                            <td><?php echo $vendedor['telefono_1']; ?></td>
                            <td><?php echo $vendedor['telefono_2'] ?: 'N/A'; ?></td>
                            <td><?php echo $vendedor['correo']; ?></td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>

<?php include_once 'footer.php'; ?>

<script>
    // Simular búsqueda
    document.getElementById('searchForm').addEventListener('submit', function (e) {
        e.preventDefault();
        const query = document.getElementById('searchInput').value;

        // Aquí podrías agregar la lógica para buscar proveedores/productos desde el servidor
        if (query.toLowerCase() === "pintura" || query.toLowerCase() === "excelencia") {
            document.getElementById('empresaInfo').style.display = 'block';
            document.getElementById('vendedoresInfo').style.display = 'block';
        } else {
            alert("No se encontraron resultados para la búsqueda.");
            document.getElementById('empresaInfo').style.display = 'none';
            document.getElementById('vendedoresInfo').style.display = 'none';
        }
    });
</script>
