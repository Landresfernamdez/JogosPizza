<?php
if(function_exists($_REQUEST['Funcion'])){
    $_REQUEST['Funcion']();
}
else
{
    echo 'La funcion no ha sido creada: Comuniquese';
}
function ObtenertodosProductos(){
    //se importa la conexion con la base de datos
    include("../conexion.php");
    $obj = file_get_contents("php://input");
    $json=json_decode($obj);
    //se declara el query
    $query="SELECT * FROM productos WHERE nombre_categoria='$json->nombre_categoria'";
    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
    $result=pg_query($con,$query)or die("Error de consulta");
    //se cierra la conexion ya que los datos se guardaron en la variable $result
    pg_close($con);
    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
    $respuesta=pg_fetch_all($result);
    // json_encode se encarga de convertir el array en un json(java script object notation)
    echo json_encode($respuesta);
}
function ObtenertodosProductosActivos(){
    //se importa la conexion con la base de datos
    include("../conexion.php");
    $obj = file_get_contents("php://input");
    $json=json_decode($obj);
    //se declara el query
    $query="SELECT * FROM productos WHERE nombre_categoria='$json->nombre_categoria' and estado='1'";
    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
    $result=pg_query($con,$query)or die("Error de consulta");
    //se cierra la conexion ya que los datos se guardaron en la variable $result
    pg_close($con);
    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
    $respuesta=pg_fetch_all($result);
    // json_encode se encarga de convertir el array en un json(java script object notation)
    echo json_encode($respuesta);
}
function ObtenertodosCategorias(){
    //se importa la conexion con la base de datos
    include("../conexion.php");
    $obj = file_get_contents("php://input");
    $json=json_decode($obj);
    //se declara el query
    $query="SELECT * FROM categorias WHERE nombre_categoria IN(SELECT c.nombre_categoria FROM categorias AS c INNER JOIN productos AS p ON p.nombre_categoria=c.nombre_categoria)";
    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
    $result=pg_query($con,$query)or die("Error de consulta");
    //se cierra la conexion ya que los datos se guardaron en la variable $result
    pg_close($con);
    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
    $respuesta=pg_fetch_all($result);
    // json_encode se encarga de convertir el array en un json(java script object notation)
    echo json_encode($respuesta);
}
function putProducto(){
    //se importa la conexion con la base de datos
    include("../conexion.php");
    //decodifica un string a json
    $obj = json_decode(file_get_contents("php://input"));
    //query de la consulta a la base de datos
    $query = "SELECT agregarProducto('$obj->nombre_producto','$obj->precio','$obj->nombre_categoria');";
    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
    $result = pg_query($con,$query);
    $response = array();
    if (!$result){
        $response = array(
            'status' => false,
            'message' => 'An error occured...',
            'data' => pg_fetch_all($result)
        );
    }else{
        $response = array(
            'status' => true,
            'message' => 'Success'
        );
    }
    echo json_encode($response, JSON_FORCE_OBJECT);
}
function postProducto(){
    //se importa la conexion con la base de datos
    include("../conexion.php");
    //decodifica un string a json
    $obj = json_decode(file_get_contents("php://input"));
    //query de la consulta a la base de datos
    $query = "SELECT modificarProducto('$obj->nombre_producto','$obj->estado');";
    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
    $result = pg_query($con,$query);
    $response = array();
    if (!$result){
        $response = array(
            'status' => false,
            'message' => 'An error occured...',
            'data' => pg_fetch_all($result)
        );
    }else{
        $response = array(
            'status' => true,
            'message' => 'Success'
        );
    }
    echo json_encode($response, JSON_FORCE_OBJECT);
}
function postallProducto(){
    //se importa la conexion con la base de datos
    include("../conexion.php");
    //decodifica un string a json
    $obj = json_decode(file_get_contents("php://input"));
    //query de la consulta a la base de datos
    $query = "SELECT modificarProductoAll('$obj->nombre_producto','$obj->precio','$obj->nombre_categoria');";
    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
    $result = pg_query($con,$query);
    $response = array();
    if (!$result){
        $response = array(
            'status' => false,
            'message' => 'An error occured...',
            'data' => pg_fetch_all($result)
        );
    }else{
        $response = array(
            'status' => true,
            'message' => 'Success'
        );
    }
    echo json_encode($response, JSON_FORCE_OBJECT);
}
function deleteProducto(){
    //se importa la conexion con la base de datos
    include("../conexion.php");
    //decodifica un string a json
    $obj = json_decode(file_get_contents("php://input"));
    //query de la consulta a la base de datos
    $query = "SELECT eliminarProducto('$obj->nombre_producto');";
    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
    $result = pg_query($con,$query);
    $response = array();
    if (!$result){
        $response = array(
            'status' => false,
            'message' => 'An error occured...',
            'data' => pg_fetch_all($result)
        );
    }else{
        $response = array(
            'status' => true,
            'message' => 'Success'
        );
    }
    echo json_encode($response, JSON_FORCE_OBJECT);
}
?>