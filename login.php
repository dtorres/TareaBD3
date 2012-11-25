<?php

session_start();
if ($_SESSION && isset($_SESSION["user"])) {
    header("Location: index.php");
    return;
}

include("conexion.php");

$user = $_POST["user"];
$pass = md5($_POST["pass"]);


$result = pg_query("SELECT * FROM alumnos WHERE email='".$user."' AND clave='".$pass."'");

if (pg_num_rows($result) > 0){
    //EXISTE
    $row = pg_fetch_row($result, 0);
    $_SESSION["user"] = $row[0];
    header("Location: index.php");
} else {
    echo "Usuario o clave invalida";
}
?>