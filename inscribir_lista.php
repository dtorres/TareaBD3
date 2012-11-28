<?
session_start();
if (!isset($_SESSION["user"])) {
    header("Location: index.php");
    return;
}

include_once("conexion.php");

if ($_POST) {
    $query = "INSERT INTO listas (nombre, vision, mision, id_dueno) VALUES ('".$_POST["nombre"]."', '".$_POST["vision"]."', '".$_POST["mision"]."', ".$_SESSION["user"].") RETURNING Currval('listas_id_seq')";
        
    $res = pg_query($query);
    
    $fetch = pg_fetch_row($res, 0);
    
    $idLista = $fetch[0];
    
    foreach ($_POST["integrante"] as $integrante) {
        $query = "INSERT INTO directivos (id_lista, id_alumno, cargo, url_foto) VALUES ($idLista, ".$integrante["id"].", '".$integrante["cargo"]."', '".$integrante["foto"]."')";
        
        pg_query($query);
        
    }

}

$query = "SELECT alumnos.id, alumnos.nombre FROM alumnos left join directivos ON alumnos.id = directivos.id_alumno WHERE directivos.id_alumno is NULL AND alumnos.id = ".$_SESSION["user"];

$res = pg_query($query);

if (pg_num_rows($res) == 0) {
    header("Location: index.php");
}

$user = pg_fetch_array($res, 0);

?>
<!DOCTYPE html>
<html lang="">
<head>
  <meta charset="utf-8">
	<title>Inscribir Lista</title>
	<meta name="description" content="" />
  	<meta name="keywords" content="" />
	<meta name="robots" content="" />
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript" charset="utf-8">
	    var users = [];
	    
	    <?php
	        	        
	        $query = "SELECT alumnos.id, alumnos.nombre FROM alumnos left join directivos ON alumnos.id = directivos.id_alumno WHERE directivos.id_alumno is NULL AND alumnos.id != ".$_SESSION["user"];
	        
	        
	        $res = pg_query($query);
	        
	        while($row = pg_fetch_array($res)) {
    	       echo "users.push({ id: ".$row[0].", nombre: '".ucfirst($row[1])."'});\n";
	        }
	    
	    ?>
	    
	    function addField(){
	        var theEl = $(".integrantesInputs");
	        var newIdx = theEl.children().length;
	        var html = "";
	        html = "<div class=\"integrante\">";
	        html += "<label for=\"integrante["+newIdx+"][id']\">Nombre</label>";
	        html += "<select name=\"integrante["+newIdx+"][id]\">";
	        var user;
	        for (idx in users) {
	            html += "<option value=\""+users[idx].id+"\">"+users[idx].nombre+"</option>";
	        }
	        html += "</select>";
	        html += "<label for=\"integrante["+newIdx+"][cargo]\">Cargo</label>";
	        html += "<input name=\"integrante["+newIdx+"][cargo]\"/>";
	        html += "<label for=\"integrante["+newIdx+"][foto]\">URL Foto</label>";
	        html += "<input name=\"integrante["+newIdx+"][foto]\"/>";
	        html += "<br/>";
	        html += "</div>";
    	    $(".integrantesInputs").append(html);
	    }	    
	    </script>
	</head>
<body>

<h1>Inscribir Lista</h1>

<form method="post">
<h2>Sobre La Lista</h2>
<label>Nombre Lista</label>
<input name="nombre"/>
<label>Vision</label>
<textarea name="vision" maxlength="500"></textarea>
<label>Mision</label>
<textarea name="mision" maxlength="500"></textarea>

<h2>Integrantes</h2>

<div class="integrantesInputs">

<div class="integrante">
    <label for="integrante[0][id]">Nombre</label>
    <select name="integrante[0][id]">
        <option value="<?=$user[0]?>"><?=ucfirst($user[1])?></option>
    </select>
    <label for="integrante[0][cargo]">Cargo</label>
    <input name="integrante[0][cargo]" value="Presidente">
    <label for="integrante[0][foto]">URL Foto</label>
    <input name="integrante[0][foto]"><br/>
</div>

</div>
<a href="javascript:addField()">Agregar Integrante</a>

<input type="submit"/>
</form>

</body>
</html>