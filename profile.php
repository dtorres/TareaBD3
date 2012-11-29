<?php

session_start();
if (!isset($_SESSION["user"])) {
    header("Location: index.php");
    return;
}

include_once("conexion.php");

$res = pg_query("SELECT * FROM alumnos WHERE id='".$_SESSION["user"]."'");

if (pg_num_rows($res) == 0) {
    session_destroy();
    header("Location: index.php");
    return;
}

$user = pg_fetch_array($res, 0); 

$user_pertenece_lista_res = pg_query("SELECT id_alumno FROM directivos WHERE id_alumno=".$user[0]);

$user_hasLista = (pg_num_rows($user_pertenece_lista_res) > 0); 

$user_hasProyecto_res = pg_query("SELECT id_alumno_dueno FROM proyectos WHERE id_alumno_dueno=".$user[0]);

$user_hasProyecto = (pg_num_rows($user_hasProyecto_res) > 0);

?>
<!DOCTYPE html>
<html lang="">
<head>
  <meta charset="utf-8">
	<title></title>
	<meta name="description" content="" />
  	<meta name="keywords" content="" />
	<meta name="robots" content="" />
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js" type="text/javascript"></script>
</head>
<body>

<a href="logout.php">Cerrar sesi&oacute;n</a>

<h1>Hola, <?= ucfirst($user[1])?></h1>

<ul>
    <? if (!$user_hasLista){ ?>
    <li><a href="inscribir_lista.php">Inscribir Lista</a></li>
    <? } else { ?>
    <li><a href="editar_lista.php">Editar Lista</a></li>
    <? } ?>
    <? if (!$user_hasProyecto){ ?>
    <li><a href="crear_proyecto.php">Inscribir Proyecto</a></li>
    <? } else { ?>
    <li><a href="editar_proyecto.php">Editar Proyecto</a></li>
    <? } ?>
    <li><a href="#">Ver Proyectos</a></li>
</ul>    

</body>
</html>