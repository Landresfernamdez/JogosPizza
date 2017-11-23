<?php
if(function_exists($_REQUEST['Funcion'])){
    $_REQUEST['Funcion']();
}
else
{
    echo 'La funcion no ha sido creada: Comuniquese';
}
function ObtenertodosPedidos(){
    //se importa la conexion con la base de datos
    include("../conexion.php");
    //se declara el query
    $query="SELECT * FROM pedido where estado='n'";
    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
    $result=pg_query($con,$query)or die("Error de consulta");
    //se cierra la conexion ya que los datos se guardaron en la variable $result
    pg_close($con);
    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
    $respuesta=pg_fetch_all($result);
    // json_encode se encarga de convertir el array en un json(java script object notation)
    echo json_encode($respuesta);
}

?>