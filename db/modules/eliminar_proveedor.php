<?php
$page_title = "EliminarProveedor";
include_once './header.php';
?>

<main>
    <div class="container mt-5">
        <h2>Eliminar Proveedor</h2>
        
        <!-- Cuadro de búsqueda -->
        <div class="mb-3">
            <label for="searchInput" class="form-label">Buscar Proveedor (RUT o Nombre de la Empresa)</label>
            <input type="text" class="form-control" id="searchInput" placeholder="Ingrese RUT o Nombre">
        </div>
        
        <!-- Información del proveedor encontrada -->
        <div id="providerInfo" class="mb-3" style="display: none;">
            <h4>Información del Proveedor</h4>
            <p><strong>RUT:</strong> <span id="providerRut"></span></p>
            <p><strong>Nombre de la Empresa:</strong> <span id="providerName"></span></p>
            <p><strong>Dirección:</strong> <span id="providerAddress"></span></p>
            <p><strong>Teléfono:</strong> <span id="providerPhone"></span></p>
        </div>
        
        <!-- Botón para eliminar -->
        <div id="deleteButtonContainer" class="mb-3" style="display: none;">
            <button id="deleteButton" class="btn btn-danger">Eliminar Proveedor</button>
        </div>
        
    </div>

    <script>
        // Simulación de proveedores (puedes reemplazarlo por datos reales de una base de datos)
        const proveedores = [
            { rut: '12345678-9', nombre: 'Empresa A', direccion: 'Calle Falsa 123', telefono: '987654321' },
            { rut: '98765432-1', nombre: 'Empresa B', direccion: 'Avenida Siempre Viva 742', telefono: '123456789' }
        ];
        
        // Elementos del DOM
        const searchInput = document.getElementById('searchInput');
        const providerInfo = document.getElementById('providerInfo');
        const providerRut = document.getElementById('providerRut');
        const providerName = document.getElementById('providerName');
        const providerAddress = document.getElementById('providerAddress');
        const providerPhone = document.getElementById('providerPhone');
        const deleteButtonContainer = document.getElementById('deleteButtonContainer');
        const deleteButton = document.getElementById('deleteButton');
        
        // Buscar proveedor por RUT o nombre
        searchInput.addEventListener('input', function () {
            const query = searchInput.value.toLowerCase();
            const foundProvider = proveedores.find(provider => provider.rut.toLowerCase().includes(query) || provider.nombre.toLowerCase().includes(query));
            
            if (foundProvider) {
                providerRut.textContent = foundProvider.rut;
                providerName.textContent = foundProvider.nombre;
                providerAddress.textContent = foundProvider.direccion;
                providerPhone.textContent = foundProvider.telefono;
                providerInfo.style.display = 'block';
                deleteButtonContainer.style.display = 'block';
                deleteButton.onclick = function() {
                    // Confirmación de eliminación
                    if (confirm('Estás a punto de eliminar este proveedor. Recuerda que no solo se eliminará el proveedor, sino también todos los vendedores asociados a él, y los artículos asociados se verán afectados al modificar su vendedor a nulo. ¿Deseas continuar?')) {
                        // Lógica para eliminar el proveedor y los vendedores asociados
                        alert('Proveedor eliminado exitosamente y los vendedores asociados han sido modificados.');
                        // Aquí puedes agregar la lógica para eliminar el proveedor de la base de datos o hacer la actualización correspondiente.
                        providerInfo.style.display = 'none'; // Ocultar información del proveedor
                        deleteButtonContainer.style.display = 'none'; // Ocultar el botón de eliminar
                        searchInput.value = ''; // Limpiar el campo de búsqueda
                    }
                };
            } else {
                providerInfo.style.display = 'none';
                deleteButtonContainer.style.display = 'none';
            }
        });
    </script>
</main>

<?php
include_once './footer.php';
?>