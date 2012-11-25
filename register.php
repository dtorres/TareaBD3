<?php

session_start();
if ($_SESSION && isset($_SESSION["user"])) {
    header("Location: index.php");
    return;
}

if ($_POST) {
$name = $_POST["name"];
$mail = $_POST["mail"];
$pass = $_POST["pass"];

$errors = array();

if ($name == "") {
    array_push($errors, "Nombre no puede estas vacio"); 
}

if ($mail == "") {
    array_push($errors, "Mail no puede estas vacio"); 
}


if ($pass == "") {
    array_push($errors, "Clave no puede estas vacio"); 
}

if (count($errors) == 0) {
    include_once("conexion.php");
    
    $result = pg_query("INSERT INTO alumnos (nombre, email, clave) VALUES ('".$name."', '".$mail."', '".md5($pass)."') RETURNING Currval('alumnos_id_seq')");
    $fch = pg_fetch_row($result, 0);
    $_SESSION["user"] = $fch[0];
    header("Location: index.php");
    return;
}

}
?>

<!DOCTYPE html>
<html lang="">
<head>
  <meta charset="utf-8">
	<title>Registrate</title>
	<meta name="description" content="" />
  	<meta name="keywords" content="" />
	<meta name="robots" content="" />
</head>
<body>

<h1>Registrate</h1>

<? if (count($errors) > 0) {
    foreach($errors as $error) { ?>
        <p><?= $error ?></p>
<?  
    }    
}
?>

<form method="post">

<label>Nombre</label>
<input value="<?= $name ?>" name="name"/>
<label>E-Mail</label>
<input value="<?= $mail ?>" name="mail"/>
<label>Clave</label>
<input name="pass" type="password"/>

<input type="submit"/>

</form>

</body>
</html>