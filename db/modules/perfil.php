<?php 
$page_title = "Perfil";
include_once 'header.php'; 

// Datos de prueba para el usuario
$user_data = [
    'primer_nombre' => 'Juan',
    'segundo_nombre' => 'Carlos',
    'primer_apellido' => 'Pérez',
    'segundo_apellido' => 'Gómez',
    'telefono_1' => '123456789',
    'telefono_2' => '987654321',
    'correo' => 'juan.perez@example.com',
    'direccion' => 'Calle Falsa 123',
    'tipo' => 'Administrador'
];
?>

<main class="container my-5">
    <h1>Cuenta de Usuario</h1>
    <form>
        <!-- Primer Nombre -->
        <div class="mb-3">
            <label for="first_name" class="form-label">Primer Nombre</label>
            <input type="text" class="form-control" id="first_name" value="<?php echo $user_data['primer_nombre']; ?>">
        </div>

        <!-- Segundo Nombre -->
        <div class="mb-3">
            <label for="second_name" class="form-label">Segundo Nombre</label>
            <input type="text" class="form-control" id="second_name" value="<?php echo $user_data['segundo_nombre']; ?>">
        </div>

        <!-- Primer Apellido -->
        <div class="mb-3">
            <label for="first_lastname" class="form-label">Primer Apellido</label>
            <input type="text" class="form-control" id="first_lastname" value="<?php echo $user_data['primer_apellido']; ?>">
        </div>

        <!-- Segundo Apellido -->
        <div class="mb-3">
            <label for="second_lastname" class="form-label">Segundo Apellido</label>
            <input type="text" class="form-control" id="second_lastname" value="<?php echo $user_data['segundo_apellido']; ?>">
        </div>

        <!-- Teléfono 1 -->
        <div class="mb-3">
            <label for="phone_1" class="form-label">Teléfono 1</label>
            <input type="text" class="form-control" id="phone_1" value="<?php echo $user_data['telefono_1']; ?>">
        </div>

        <!-- Teléfono 2 -->
        <div class="mb-3">
            <label for="phone_2" class="form-label">Teléfono 2</label>
            <input type="text" class="form-control" id="phone_2" value="<?php echo $user_data['telefono_2']; ?>">
        </div>

        <!-- Correo -->
        <div class="mb-3">
            <label for="email" class="form-label">Correo Electrónico</label>
            <input type="email" class="form-control" id="email" value="<?php echo $user_data['correo']; ?>">
        </div>

        <!-- Dirección -->
        <div class="mb-3">
            <label for="address" class="form-label">Dirección</label>
            <input type="text" class="form-control" id="address" value="<?php echo $user_data['direccion']; ?>">
        </div>

        <!-- Tipo -->
        <div class="mb-3">
            <label for="type" class="form-label">Tipo de Usuario</label>
            <input type="text" class="form-control" id="type" value="<?php echo $user_data['tipo']; ?>" readonly>
        </div>

        <!-- Botón para guardar cambios -->
        <button type="button" class="btn btn-primary btn-lg">Modificar</button>
    </form>
</main>

<?php include_once 'footer.php'; ?>
