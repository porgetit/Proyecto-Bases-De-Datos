<?php
$page_title = "Login";
include_once './header.php';
?>

<!-- <div class="login-container" style="max-width: 400px; margin: 50px auto; padding: 30px; background-color: #fff; border-radius: 8px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
    <h2>Iniciar sesión</h2>
    <form action="#" method="POST">
        <div class="form-group">
            <label for="docNumber">Número de documento</label>
            <input type="text" class="form-control" id="docNumber" name="docNumber" placeholder="Ingrese su número de documento" required>
        </div>
        <div class="form-group">
            <label for="password">Contraseña</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Ingrese su contraseña" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Iniciar sesión</button>
    </form>
</div> -->

<div class="login-container" style="max-width: 400px; margin: 50px auto; padding: 30px; background-color: #fff; border-radius: 8px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
    <h2>Iniciar sesión</h2>
    <form action="#" method="POST">
        <div class="form-group">
            <label for="docNumber">Número de documento</label>
            <input type="text" class="form-control" id="docNumber" name="docNumber" placeholder="Ingrese su número de documento" required>
        </div>
        <div class="form-group mt-3">
            <label for="password">Contraseña</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Ingrese su contraseña" required>
        </div>
        <div class="form-group mt-3">
            <button type="submit" class="btn btn-primary w-100" id="Submit">Iniciar sesión</button>
        </div>
    </form>
</div>

<script>
    function redirectToURL(url) {
        window.location.href = url;
    }

    document.getElementById('Submit').addEventListener('click', function() {
        redirectToURL('./ventas.php');
    });
</script>

<?php
include_once './footer.php';
?>