<?
session_start();
    if (!isset($_SESSION["user"])) {
    header("Location: index.php");
    return;
}

include_once("conexion.php");

if ($_POST) {
    $query = "INSERT INTO proyectos (titulo, descripcion, id_departamento, id_alumno_dueno) VALUES ('".$_POST["titulo"]."', '".$_POST["descripcion"]."', '".$_POST["departamento"]."', ".$_SESSION["user"].") RETURNING Currval('proyectos_id_seq')";
    
    $res = pg_query($query);
    
    $fetch = pg_fetch_row($res, 0);
    
    $idProy = $fetch[0];
    
    foreach ($_POST["etapa"] as $integrante) {
        $query = "INSERT INTO etapas (id_proyecto, id_responsable, descripcion, fecha_inicio, fecha_termino) VALUES ($idProy, ".$integrante["id_responsable"].", '".$integrante["descripcion"]."', '".$integrante["fecha_inicio"]."', '".$integrante["fecha_termino"]."')";
        
        pg_query($query);
        
    }
    
    
}

$resdptos = pg_query("SELECT * FROM departamentos");

?>

<html lang="">
<head>
  <meta charset="utf-8">
  <title></title>
  <meta name="description" content="" />
  <meta name="keywords" content="" />
  <meta name="robots" content="" />
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js" type="text/javascript"></script>
  <script type="text/javascript" charset="utf-8">
	    var users = [];
	    
	    <?php
	        	        
	        $query = "SELECT alumnos.id, alumnos.nombre FROM alumnos";
	        
	        
	        $res = pg_query($query);
	        
	        while($row = pg_fetch_array($res)) {
    	       echo "users.push({ id: ".$row[0].", nombre: '".ucfirst($row[1])."'});\n";
	        }
	    
	    ?>
	    
	    function addField(){
	        var theEl = $(".etapas");
	        var newIdx = theEl.children().length;
	        var html = "";
	        html = "<div class=\"etapa\">";
	        html += "<label for=\"etapa["+newIdx+"][id_responsable]\">Encargado</label>";
	        html += "<select name=\"etapa["+newIdx+"][id_responsable]\">";
	        var user;
	        for (idx in users) {
	            html += "<option value=\""+users[idx].id+"\">"+users[idx].nombre+"</option>";
	        }
	        html += "</select>";
	        html += "<label for=\"etapa["+newIdx+"][descripcion]\">Descripcion</label>";
	        html += "<input name=\"etapa["+newIdx+"][descripcion]\"/>";
	        html += "<label for=\"integrante["+newIdx+"][fecha_inicio]\">Fecha Inicio</label>";
	        html += "<input name=\"integrante["+newIdx+"][fecha_inicio]\"/>";
	        html += "<label for=\"integrante["+newIdx+"][fecha_termino]\">Fecha Termino</label>";
	        html += "<input name=\"integrante["+newIdx+"][fecha_termino]\"/>";
	        html += "<br/>";
	        html += "</div>";
    	    theEl.append(html);
	    }	    
    </script>
</head>
<body>

<h1>Crear Proyecto</h1>

<form method="post">

<label>Titulo</label>
<input name="titulo"/>

<label>descripcion</label>
<textarea name="descripcion"></textarea>

<label>Departamento asociado</label>
<select name="departamento">
<? if (pg_num_rows($resdptos) > 0) {
    while ($row = pg_fetch_array($resdptos)) {
?>
    <option value="<?=$row["id"]?>"><?=$row["nombre"]?></option>  
<?  }
} else { ?>
    
    <option value="-1">No hay dptos, modifique su proyecto despues para asignar uno.</option>
<? } ?>
</select>
<h2>Etapas</h2>

<div class="etapas">
</div>
<a href="javascript:addField()">+ Agregar Etapa</a>

<input type="submit"/>
</form>

</body>

<script type="text/javascript">
addField();
</script>
</html>
