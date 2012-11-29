<?php

session_start();
    if (!isset($_SESSION["user"])) {
    header("Location: index.php");
    return;
}

include_once("conexion.php");

if ($_POST) {
    pg_query("UPDATE listas SET nombre='".$_POST["nombre"]."', vision='".$_POST["vision"]."', mision='".$_POST["mision"]."' WHERE id_dueno='".$_SESSION["user"]."'");
}


$res = pg_query("SELECT * FROM listas WHERE id_dueno='".$_SESSION["user"]."'");

if (pg_num_rows($res) == 0) {
    header("Location: index.php");
    return;
}

$lista = pg_fetch_array($res, 0);

?>
<!DOCTYPE html>
<html lang="">
<head>
  <meta charset="utf-8">
	<title>Editar Lista</title>
	<meta name="description" content="" />
  	<meta name="keywords" content="" />
	<meta name="robots" content="" />
</head>
<body>

<ul>
    <li><a href="crear_dpto.php">Inscribir Dpto.</a></li>
    <li><a href="#">Inscribir Delegado</a></li>
    <li><a href="crear_proyecto.php">Crear Proyecto</a></li>
</ul>

<h1>Editar Datos</h1>

<form method="post">

<h2>Sobre La Lista</h2>
<label>Nombre Lista</label>
<input name="nombre" value="<?= $lista["nombre"]?>"/>
<label>Vision</label>
<textarea name="vision" maxlength="500"><?= $lista["vision"] ?></textarea>
<label>Mision</label>
<textarea name="mision" maxlength="500"><?= $lista["mision"] ?></textarea>

<input type="submit"/>
</form>

</body>
</html>