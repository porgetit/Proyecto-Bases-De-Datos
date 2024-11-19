<?php
$page_title = "ModificarProveedor";
include_once './header.php';

$proveedores = [
    [
        "rut" => "12345678-9",
        "nombre" => "Proveedor A",
        "telefono1" => "123456789",
        "telefono2" => "987654321",
        "correo" => "contacto@proveedora.com",
        "direccion" => "Calle Falsa 123",
        "vendedores" => [
            [
                "nid" => "101",
                "primerNombre" => "Juan",
                "segundoNombre" => "Carlos",
                "primerApellido" => "Pérez",
                "segundoApellido" => "López",
                "telefono1" => "111111111",
                "telefono2" => "222222222",
                "correo" => "juan.perez@proveedora.com"
            ],
            [
                "nid" => "102",
                "primerNombre" => "Ana",
                "segundoNombre" => "María",
                "primerApellido" => "García",
                "segundoApellido" => "Fernández",
                "telefono1" => "333333333",
                "telefono2" => "444444444",
                "correo" => "ana.garcia@proveedora.com"
            ],
        ]
    ],
    [
        "rut" => "87654321-0",
        "nombre" => "Proveedor B",
        "telefono1" => "987654321",
        "telefono2" => "123456789",
        "correo" => "contacto@proveedorb.com",
        "direccion" => "Av. Siempre Viva 742",
        "vendedores" => [
            [
                "nid" => "201",
                "primerNombre" => "Carlos",
                "segundoNombre" => "Andrés",
                "primerApellido" => "Ramírez",
                "segundoApellido" => "Gómez",
                "telefono1" => "555555555",
                "telefono2" => "666666666",
                "correo" => "carlos.ramirez@proveedorb.com"
            ]
        ]
    ],
    [
        "rut" => "11223344-5",
        "nombre" => "Proveedor C",
        "telefono1" => "666777888",
        "telefono2" => "888777666",
        "correo" => "contacto@proveedorc.com",
        "direccion" => "Carrera 8 #34-56",
        "vendedores" => [
            [
                "nid" => "301",
                "primerNombre" => "María",
                "segundoNombre" => "Elena",
                "primerApellido" => "López",
                "segundoApellido" => "Martínez",
                "telefono1" => "777777777",
                "telefono2" => "888888888",
                "correo" => "maria.lopez@proveedorc.com"
            ],
            [
                "nid" => "302",
                "primerNombre" => "Luis",
                "segundoNombre" => "Fernando",
                "primerApellido" => "Martínez",
                "segundoApellido" => "Hernández",
                "telefono1" => "999999999",
                "telefono2" => "000000000",
                "correo" => "luis.martinez@proveedorc.com"
            ],
        ]
    ]
];

?>

<main class="container my-5">
    <h1 class="text-primary">Modificar Proveedor</h1>
    <p class="text-muted">Busque la empresa y modifique los datos necesarios.</p>

    <!-- Cuadro de búsqueda -->
    <div class="mb-4">
        <label for="buscarProveedor" class="form-label">Buscar Empresa (por nombre o RUT):</label>
        <input type="text" class="form-control" id="buscarProveedor" placeholder="Ingrese el nombre o RUT">
    </div>

    <!-- Información del proveedor -->
    <div id="informacionProveedor" class="d-none">
        <!-- Información de la empresa -->
        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <h5 class="card-title text-success">Información de la Empresa</h5>
                <form id="formModificarEmpresa">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="rut" class="form-label">RUT</label>
                            <input type="text" class="form-control" id="rut" readonly>
                        </div>
                        <div class="col-md-6">
                            <label for="nombreEmpresa" class="form-label">Nombre de la Empresa</label>
                            <input type="text" class="form-control" id="nombreEmpresa">
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="telefono1" class="form-label">Teléfono 1</label>
                            <input type="text" class="form-control" id="telefono1">
                        </div>
                        <div class="col-md-6">
                            <label for="telefono2" class="form-label">Teléfono 2</label>
                            <input type="text" class="form-control" id="telefono2">
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="correoEmpresa" class="form-label">Correo Electrónico</label>
                            <input type="email" class="form-control" id="correoEmpresa">
                        </div>
                        <div class="col-md-6">
                            <label for="direccionEmpresa" class="form-label">Dirección</label>
                            <input type="text" class="form-control" id="direccionEmpresa">
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Información de los Vendedores -->
        <div id="vendedoresInfo" class="mt-4">
            <h4>Vendedores</h4>
            <!-- Lista de Vendedores -->
            <div id="vendedoresContainer"></div>
            <div class="mb-3">
                <button class="btn btn-primary" id="addVendedor">Agregar Vendedor</button>
            </div>
        </div>

        <!-- Botón para guardar -->
        <button type="submit" class="btn btn-success w-100 mt-3" id="guardarCambios">Guardar Cambios</button>
    </div>
</main>

<script>
// Datos de prueba
const proveedores = <?php echo json_encode($proveedores); ?>;

// Referencias a elementos
const buscarInput = document.getElementById('buscarProveedor');
const infoProveedor = document.getElementById('informacionProveedor');
const vendedoresContainer = document.getElementById('vendedoresContainer');

// Función para buscar proveedor
buscarInput.addEventListener('input', function () {
    const search = this.value.toLowerCase();
    const proveedor = proveedores.find(p =>
        p.rut.toLowerCase().includes(search) || p.nombre.toLowerCase().includes(search)
    );

    if (proveedor) {
        mostrarProveedor(proveedor);
        infoProveedor.classList.remove('d-none');
    } else {
        infoProveedor.classList.add('d-none');
    }
});

// Mostrar información del proveedor
function mostrarProveedor(proveedor) {
    document.getElementById('rut').value = proveedor.rut;
    document.getElementById('nombreEmpresa').value = proveedor.nombre;
    document.getElementById('telefono1').value = proveedor.telefono1;
    document.getElementById('telefono2').value = proveedor.telefono2;
    document.getElementById('correoEmpresa').value = proveedor.correo;
    document.getElementById('direccionEmpresa').value = proveedor.direccion;

    // Renderizar vendedores
    vendedoresContainer.innerHTML = '';
    proveedor.vendedores.forEach(vendedor => {
        agregarVendedor(vendedor);
    });
}

// Agregar un vendedor al DOM
function agregarVendedor(vendedor = {}) {
    const vendedorHTML = `
        <div class="vendedor row mb-3 border p-3 rounded">
            <div class="col-md-6">
                <label class="form-label">NID</label>
                <input type="text" class="form-control" value="${vendedor.nid || ''}" placeholder="Ingrese el NID">
            </div>
            <div class="col-md-6">
                <label class="form-label">Primer Nombre</label>
                <input type="text" class="form-control" value="${vendedor.primerNombre || ''}" placeholder="Ingrese el primer nombre">
            </div>
            <div class="col-md-6 mt-3">
                <label class="form-label">Segundo Nombre</label>
                <input type="text" class="form-control" value="${vendedor.segundoNombre || ''}" placeholder="Ingrese el segundo nombre">
            </div>
            <div class="col-md-6 mt-3">
                <label class="form-label">Primer Apellido</label>
                <input type="text" class="form-control" value="${vendedor.primerApellido || ''}" placeholder="Ingrese el primer apellido">
            </div>
            <div class="col-md-6 mt-3">
                <label class="form-label">Segundo Apellido</label>
                <input type="text" class="form-control" value="${vendedor.segundoApellido || ''}" placeholder="Ingrese el segundo apellido">
            </div>
            <div class="col-md-6 mt-3">
                <label class="form-label">Teléfono 1</label>
                <input type="text" class="form-control" value="${vendedor.telefono1 || ''}" placeholder="Ingrese el teléfono 1">
            </div>
            <div class="col-md-6 mt-3">
                <label class="form-label">Teléfono 2</label>
                <input type="text" class="form-control" value="${vendedor.telefono2 || ''}" placeholder="Ingrese el teléfono 2">
            </div>
            <div class="col-md-6 mt-3">
                <label class="form-label">Correo Electrónico</label>
                <input type="email" class="form-control" value="${vendedor.correo || ''}" placeholder="Ingrese el correo">
            </div>
            <div class="col-12 mt-3 text-end">
                <button class="btn btn-danger btn-sm removeSeller">Eliminar</button>
            </div>
        </div>
    `;
    vendedoresContainer.insertAdjacentHTML('beforeend', vendedorHTML);
}

// Delegar el evento de eliminar en el contenedor de vendedores
vendedoresContainer.addEventListener('click', function(event) {
    if (event.target.classList.contains('removeSeller')) {
        event.target.closest('.vendedor').remove();
    }
});

// Botón para agregar nuevo vendedor
document.getElementById('addVendedor').addEventListener('click', function () {
    agregarVendedor();
});
</script>

<?php
include_once './footer.php';
?>
