<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $page_title; ?> - Ferrepinturas Colormax</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <style>
        html {
            font-size: 1rem;
        }

        @include media-breakpoint-up(sm) {
            html {
                font-size: 1.2rem;
            }
        }

        @include media-breakpoint-up(md) {
            html {
                font-size: 1.4rem;
            }
        }

        @include media-breakpoint-up(lg) {
            html {
                font-size: 1.6rem;
            }
        }
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa; /* Blanco grisáceo */
            color: #343a40; /* Gris oscuro */
        }
        .navbar {
            background-color: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .navbar a {
            color: #343a40;
        }
        .navbar a:hover {
            color: #007bff;
        }
        .sticky-top {
            z-index: 1030;
        }
        table.table-striped tbody tr:nth-of-type(odd) {
            background-color: #f8f9fa; /* Gris claro */
        }
        table.table-striped tbody tr:nth-of-type(even) {
            background-color: #ffffff; /* Blanco */
        }
        table {
            border: none;
        }
        th, td {
            border: none;
            text-align: center;
        }        
        .navbar-nav .dropdown-menu {
            right: auto; /* Elimina la alineación hacia la derecha */
            left: auto;  /* Permite que el posicionamiento sea relativo al botón */
            transform: translate(0, 10px); /* Ajusta el menú hacia abajo */
            min-width: auto; /* Elimina el ancho mínimo innecesario */
        }
        .dropdown-menu {
            margin-top: 0; /* Evita márgenes adicionales */
            position: absolute; /* Asegura que el menú se posicione correctamente */
        }
    </style>
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-lg sticky-top">
            <div class="container">
                <a class="navbar-brand d-flex align-items-center gap-2" href="../index.php">
                    <img src="<?php echo ($page_title == "Inicio") ? './sources/logo-hammer.svg' : '../sources/logo-hammer.svg'; ?>" alt="Logo" width="40" height="40">
                    <h3 class="m-0"><strong>Ferrepinturas Colormax</strong></h3>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <?php
                switch ($page_title) {
                    case "Inicio":
                        echo '
                        <div class="d-flex flex-column flex-md-row align-items-center gap-2 mt-3 mt-md-0">
                            <button class="btn btn-primary" id="IniciarSesion">Iniciar Sesión</button>
                            <button class="btn btn-outline-primary" id="Registrarse">Registrarse</button>
                        </div>
                        ';
                        break;
                    case "Ventas":
                        echo '
                        <div class="d-flex flex-column flex-md-row align-items-center gap-2 mt-3 mt-md-0 dropdown">
                            <button class="btn btn-primary" id="NuevaVenta">Nuevo</button>
                            <button class="btn btn-secondary" id="ModificarVenta">Modificar</button>
                            <button class="btn btn-danger" id="EliminarVenta">Eliminar</button>
                            <button class="btn dropdown-toggle d-flex align-items-center" id="profileDropdown" type="button" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false" style="background: none; border: none; padding: 0;">
                                <img src="../sources/person-circle.svg" alt="Perfil" class="rounded-circle" style="width: 30px; height: 30px;">
                            </button>
                            <div class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown" style="top: 100%; left: 0;">
                                <button class="dropdown-item" type="button" id="Cuenta">Cuenta</button>
                                <button class="dropdown-item" type="button" id="Inventario">Inventario</button>
                                <button class="dropdown-item" type="button" id="Proveedores">Proveedores</button>
                                <button class="dropdown-item" type="button" id="CerrarSesion">Cerrar sesión</button>
                            </div>
                        </div>
                        ';
                        break;
                    case "RegistroVentas":
                        echo '
                        <div class="d-flex flex-column flex-md-row align-items-center gap-2 mt-3 mt-md-0">
                            <button class="btn btn-danger" id="CancelarVenta">Cancelar</button>
                        </div>
                        ';
                        break;
                    case "Login":
                        echo '
                        <div class="d-flex flex-column flex-md-row align-items-center gap-2 mt-3 mt-md-0">
                            <button class="btn btn-secondary" id="CancelarLogin">Volver</button>
                        </div>
                        ';
                        break;
                    case "ModificarVenta":
                        echo '
                        <div class="d-flex flex-column flex-md-row align-items-center gap-2 mt-3 mt-md-0">
                            <button class="btn btn-danger" id="CancelarModificarVenta">Cancelar</button>
                        </div>
                        ';
                        break;
                    case "EliminarVenta":
                        echo '
                        <div class="d-flex flex-column flex-md-row align-items-center gap-2 mt-3 mt-md-0">
                            <button class="btn btn-danger" id="CancelarEliminarVenta">Cancelar</button>
                        </div>
                        ';
                        break;
                    case "Perfil":
                        echo '
                        <div class="d-flex flex-column flex-md-row align-items-center gap-2 mt-3 mt-md-0">
                            <button class="btn btn-secondary" id="VolverPerfil">Volver</button>
                        </div>
                        ';
                        break;
                    case "Inventario":
                        echo '
                        <div class="d-flex flex-column flex-md-row align-items-center gap-2 mt-3 mt-md-0 dropdown">
                            <button class="btn btn-primary" id="NuevoProducto">Nuevo</button>
                            <button class="btn btn-secondary" id="ModificarProducto">Modificar</button>
                            <button class="btn btn-danger" id="EliminarProducto">Eliminar</button>
                            <button class="btn dropdown-toggle d-flex align-items-center" id="profileDropdown" type="button" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false" style="background: none; border: none; padding: 0;">
                                <img src="../sources/person-circle.svg" alt="Perfil" class="rounded-circle" style="width: 30px; height: 30px;">
                            </button>
                            <div class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown" style="top: 100%; left: 0;">
                                <button class="dropdown-item" type="button" id="Cuenta">Cuenta</button>
                                <button class="dropdown-item" type="button" id="Ventas">Ventas</button>
                                <button class="dropdown-item" type="button" id="Proveedores">Proveedores</button>
                                <button class="dropdown-item" type="button" id="CerrarSesion">Cerrar sesión</button>
                            </div>
                        </div>
                        ';
                        break;
                    case "AgregarProducto":
                        echo '
                        <div class="d-flex flex-column flex-md-row align-items-center gap-2 mt-3 mt-md-0">
                            <button class="btn btn-danger" id="CancelarAgregarProducto">Cancelar</button>
                        </div>
                        ';
                        break;
                    case "ModificarProducto":
                        echo '
                        <div class="d-flex flex-column flex-md-row align-items-center gap-2 mt-3 mt-md-0">
                            <button class="btn btn-danger" id="CancelarModificarProducto">Cancelar</button>
                        </div>
                        ';
                        break;
                    case "EliminarProducto":
                        echo '
                        <div class="d-flex flex-column flex-md-row align-items-center gap-2 mt-3 mt-md-0">
                            <button class="btn btn-danger" id="CancelarEliminarProducto">Cancelar</button>
                        </div>
                        ';
                        break;
                }
                ?>
            </div>
        </nav>
    </header>

    <script>
        function redirectToURL(url) {
            window.location.href = url;
        }

        const page_title = "<?php echo $page_title; ?>"

        switch (page_title) {
            case "Inicio":
                document.getElementById('IniciarSesion').addEventListener('click', function() {
                    redirectToURL('./modules/login.php');
                });

                document.getElementById('Registrarse').addEventListener('click', function() {
                    redirectToURL('#');
                });
                break;
            case "Ventas":
                document.getElementById('NuevaVenta').addEventListener('click', function() {
                    redirectToURL('./registro_venta.php');
                });

                document.getElementById('ModificarVenta').addEventListener('click', function() {
                    redirectToURL('./modifcar_venta.php');
                });

                document.getElementById('EliminarVenta').addEventListener('click', function() {
                    redirectToURL('./eliminar_venta.php');
                });

                document.getElementById('Cuenta').addEventListener('click', function() {
                    redirectToURL('./perfil.php');
                });

                document.getElementById('Inventario').addEventListener('click', function() {
                    redirectToURL('./inventario.php');
                });

                document.getElementById('Proveedores').addEventListener('click', function() {
                    redirectToURL('#');
                });

                document.getElementById('CerrarSesion').addEventListener('click', function() {
                    redirectToURL('../index.php');
                });
                break;
            case "RegistroVentas":
                document.getElementById('CancelarVenta').addEventListener('click', function() {
                    redirectToURL('./ventas.php');
                });
                break;
            case "Login":
                document.getElementById('CancelarLogin').addEventListener('click', function() {
                    redirectToURL('../index.php');
                });
                break;
            case "ModificarVenta":
                document.getElementById('CancelarModificarVenta').addEventListener('click', function() {
                    redirectToURL('./ventas.php');
                });
                break;
            case "EliminarVenta":
                document.getElementById('CancelarEliminarVenta').addEventListener('click', function() {
                    redirectToURL('./ventas.php');
                });
                break;
            case "Perfil":
                document.getElementById('VolverPerfil').addEventListener('click', function() {
                    redirectToURL('./ventas.php');
                });
                break;
            case "Inventario":
                document.getElementById('NuevoProducto').addEventListener('click', function() {
                    redirectToURL('./nuevo_producto.php');
                });

                document.getElementById('ModificarProducto').addEventListener('click', function() {
                    redirectToURL('./modificar_producto.php');
                });

                document.getElementById('EliminarProducto').addEventListener('click', function() {
                    redirectToURL('./eliminar_producto.php');
                });

                document.getElementById('Cuenta').addEventListener('click', function() {
                    redirectToURL('./perfil.php');
                });

                document.getElementById('Ventas').addEventListener('click', function() {
                    redirectToURL('./ventas.php');
                });

                document.getElementById('Proveedores').addEventListener('click', function() {
                    redirectToURL('#');
                });

                document.getElementById('CerrarSesion').addEventListener('click', function() {
                    redirectToURL('../index.php');
                });
                break;
            case "AgregarProducto":
                document.getElementById('CancelarAgregarProducto').addEventListener('click', function() {
                    redirectToURL('./inventario.php');
                });
                break;
            case "ModificarProducto":
                document.getElementById('CancelarModificarProducto').addEventListener('click', function() {
                    redirectToURL('./inventario.php');
                });
                break;
            case "EliminarProducto":
                document.getElementById('CancelarEliminarProducto').addEventListener('click', function() {
                    redirectToURL('./inventario.php');
                });
                break;
        }
       
    </script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
