<?php 
$page_title = "AgregarProveedor";
include_once 'header.php'; 
?>

<main class="container my-5">
    <h1 class="text-primary">Agregar Proveedor</h1>
    <p class="text-muted">Ingrese los datos de la empresa y sus vendedores asociados.</p>

    <!-- Formulario de Empresa -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <h5 class="card-title text-success">Información de la Empresa</h5>
            <form id="formProveedor">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="rut" class="form-label">RUT</label>
                        <input type="text" class="form-control" id="rut" placeholder="Ingrese el RUT" required>
                    </div>
                    <div class="col-md-6">
                        <label for="nombreEmpresa" class="form-label">Nombre de la Empresa</label>
                        <input type="text" class="form-control" id="nombreEmpresa" placeholder="Ingrese el nombre de la empresa" required>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="telefono1" class="form-label">Teléfono 1</label>
                        <input type="text" class="form-control" id="telefono1" placeholder="Ingrese el teléfono principal" required>
                    </div>
                    <div class="col-md-6">
                        <label for="telefono2" class="form-label">Teléfono 2</label>
                        <input type="text" class="form-control" id="telefono2" placeholder="Ingrese el teléfono secundario">
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="correoEmpresa" class="form-label">Correo Electrónico</label>
                        <input type="email" class="form-control" id="correoEmpresa" placeholder="Ingrese el correo electrónico" required>
                    </div>
                    <div class="col-md-6">
                        <label for="direccionEmpresa" class="form-label">Dirección</label>
                        <input type="text" class="form-control" id="direccionEmpresa" placeholder="Ingrese la dirección" required>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Lista de Vendedores -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <h5 class="card-title text-secondary">Vendedores Asociados</h5>
            <div id="vendedoresContainer">
                <!-- Vendedor por defecto -->
                <div class="vendedor row mb-3 border p-3 rounded">
                    <div class="col-md-6">
                        <label for="nid" class="form-label">NID</label>
                        <input type="text" class="form-control" name="nid[]" placeholder="Ingrese el NID" required>
                    </div>
                    <div class="col-md-6">
                        <label for="primerNombre" class="form-label">Primer Nombre</label>
                        <input type="text" class="form-control" name="primerNombre[]" placeholder="Ingrese el primer nombre" required>
                    </div>
                    <div class="col-md-6 mt-3">
                        <label for="segundoNombre" class="form-label">Segundo Nombre</label>
                        <input type="text" class="form-control" name="segundoNombre[]" placeholder="Ingrese el segundo nombre">
                    </div>
                    <div class="col-md-6 mt-3">
                        <label for="primerApellido" class="form-label">Primer Apellido</label>
                        <input type="text" class="form-control" name="primerApellido[]" placeholder="Ingrese el primer apellido" required>
                    </div>
                    <div class="col-md-6 mt-3">
                        <label for="segundoApellido" class="form-label">Segundo Apellido</label>
                        <input type="text" class="form-control" name="segundoApellido[]" placeholder="Ingrese el segundo apellido">
                    </div>
                    <div class="col-md-6 mt-3">
                        <label for="telefono1Vendedor" class="form-label">Teléfono 1</label>
                        <input type="text" class="form-control" name="telefono1Vendedor[]" placeholder="Ingrese el teléfono principal" required>
                    </div>
                    <div class="col-md-6 mt-3">
                        <label for="telefono2Vendedor" class="form-label">Teléfono 2</label>
                        <input type="text" class="form-control" name="telefono2Vendedor[]" placeholder="Ingrese el teléfono secundario">
                    </div>
                    <div class="col-md-6 mt-3">
                        <label for="correoVendedor" class="form-label">Correo Electrónico</label>
                        <input type="email" class="form-control" name="correoVendedor[]" placeholder="Ingrese el correo electrónico" required>
                    </div>
                </div>
            </div>
            <button type="button" class="btn btn-outline-primary mt-3" id="addVendedor">Agregar Vendedor</button>
        </div>
    </div>

    <!-- Botón para Guardar -->
    <button type="submit" class="btn btn-success w-100" id="guardarProveedor">Guardar</button>
</main>

<?php include_once 'footer.php'; ?>

<script>
    // Función para agregar un nuevo vendedor
    document.getElementById('addVendedor').addEventListener('click', function() {
        const vendedoresContainer = document.getElementById('vendedoresContainer');
        const vendedorTemplate = document.querySelector('.vendedor');
        const nuevoVendedor = vendedorTemplate.cloneNode(true);
        nuevoVendedor.querySelectorAll('input').forEach(input => input.value = '');
        vendedoresContainer.appendChild(nuevoVendedor);
    });

    // Lógica de guardado (solo ejemplo, puede integrarse con backend)
    document.getElementById('guardarProveedor').addEventListener('click', function() {
        alert('El nuevo proveedor ha sido registrado exitosamente.');
    });
</script>
