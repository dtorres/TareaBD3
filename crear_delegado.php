<?
	include_once("conexion.php");
	session_start();
	
	$query_id = "SELECT id_lista FROM directivos WHERE id_alumno =".$_SESSION["user"];
	
	
	$id_lista = pg_fetch_array(pg_query($query_id));
	$id_lista = $id_lista[0];

	
	if ($_POST) {
			
		$query = "INSERT INTO directivos (id_alumno, id_lista, cargo, url_foto) VALUES (".$_POST["alumno_id"].", $id_lista, '".$_POST["cargo"]."', '".$_POST["foto_url"]."')";
		pg_query($query);
		
		if ($_POST["id_dpto"] != "-99") {
		
		$query = "UPDATE departamentos SET id_alumno_delegado=".$_POST["id_dpto"];
		
		pg_query($query);
		
		} else {
		$query = "INSERT INTO departamentos (nombre, id_lista, id_alumno_delgado) VALUES ('".$_POST["nombre_dpto"]."', $id_lista, '".$_POST["alumno_id"]."')";
		
		pg_query($query);
		
		}
		
		return; 
	}
	
	$query = "SELECT alumnos.id, alumnos.nombre FROM alumnos left join directivos ON alumnos.id = directivos.id_alumno WHERE directivos.id_alumno is NULL AND alumnos.id != ".$_SESSION["user"];
	$res_users = pg_query($query);
	
	$query_dptos = "SELECT * FROM departamentos WHERE id_lista = ".$id_lista;
	
	$res_dptos = pg_query($query_dptos);
	
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<title></title>
	</head>
	<body>
	
	<form method="post">
	<h1>Crear Delgado</h1>
	<label>Alumno:</label>
	<select name="alumno_id">
	<? while ($row = pg_fetch_array($res_users)) { ?>
	<option value="<?= $row["id"] ?>"><?= $row["nombre"]?></option>
	
	<? } ?>
		
	</select>
	<label>Cargo</label>
	<input name="cargo" />
	<label>Foto</label>
	<input name="foto_url"/>
	
	<h2>Departamento</h2>
	
	<h3>Asignar Dpto</h3>
	
	<select name="id_dpto">
		<option value="-99">Seleccionar un Dpto</option>
		<? while ($row = pg_fetch_array($res_dptos)) { ?>
		<option value="<?=$row["id"]?>"><?=$row["nombre"]?></option>
		<? } ?>
	</select>
	
	<h3>O Crear y asignar Depto</h3>
	
	<label>Nombre</label>
	<input name="nombre_dpto"/>
	<br/>
	<input type="submit"/>
	</form>
	
	</body>
</html>
