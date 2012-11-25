<?
session_start();
if ($_SESSION && isset($_SESSION["user"])) {
    header("Location: profile.php");
    return;
}
?>

<!DOCTYPE html>
<html lang="">
<head>
  <meta charset="utf-8">
	<title>ELECCIONES CEEINF 2013</title>
	<meta name="description" content="" />
  	<meta name="keywords" content="" />
	<meta name="robots" content="" />
</head>
<body>

<h1>Bienvenido</h1>

<form method="post" action="login.php">

<label for="user">Usuario:</label>
<input type="text" name="user"/>
<label for="user">Password:</label>
<input type="password" name="pass"/>

<input type="submit" />

</form>

<a href="register.php">Registrate Aqui</a>

</body>
</html>