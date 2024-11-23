<?php
class ConexionDB {
    private $servidor;
    private $nombreBaseDatos;
    private $usuario;
    private $contraseña;
    private $conexion;

    public function __construct($servidor = 'localhost', $nombreBaseDatos = 'app_db', $usuario = 'root', $contraseña = '') {
        $this->servidor = $servidor;
        $this->nombreBaseDatos = $nombreBaseDatos;
        $this->usuario = $usuario;
        $this->contraseña = $contraseña;
        $this->conexion = null;
    }

    // Método para abrir la conexión
    private function abrirConexion() {
        $this->conexion = new mysqli(
            $this->servidor,
            $this->usuario,
            $this->contraseña,
            $this->nombreBaseDatos
        );

        // Verificar si la conexión fue exitosa
        if ($this->conexion->connect_error) {
            die("Error de conexión: " . $this->conexion->connect_error);
        }
    }

    // Método para cerrar la conexión
    private function cerrarConexion() {
        if ($this->conexion !== null) {
            $this->conexion->close();
            $this->conexion = null;
        }
    }

    // Método para ejecutar una consulta
    public function ejecutarConsulta($sql) {
        $this->abrirConexion();

        $resultado = $this->conexion->query($sql);
        if (!$resultado) {
            die("Error en la consulta: " . $this->conexion->error);
        }

        $this->cerrarConexion();
        return $resultado;
    }
}

// Uso de la clase
// $conexionDB = new ConexionDB();

?>
