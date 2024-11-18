<?php
$page_title = "Inicio";
include_once './modules/header.php';
?>

<main class="container my-5 text-center">
    <section class="mb-5">
        <h1 class="mb-3">Bienvenido a la plataforma de gestión de <strong>Ferrepintuas Colormax</strong></h1>
        <p class="lead text-muted">Esta plataforma está diseñada para facilitar la gestión de ventas, inventarios, compras y más, asegurando eficiencia y precisión para la empresa.</p>
        <img src="./sources/worker.jpg" alt="Trabajador feliz sosteniendo una pulidora" class="img-fluid my-4" style="max-width: 80%; height: auto; border-radius: 8px;">
    </section>
    <section>
        <div class="alert alert-warning" role="alert">
            <strong>Advertencia:</strong> El acceso a este sitio está restringido exclusivamente a personal autorizado. Cualquier intento de acceso no autorizado será registrado.
        </div>
    </section>
</main>

<?php
include_once './modules/footer.php';
?>
