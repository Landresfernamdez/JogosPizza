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
function ObtenertodosDetalles(){
    //se importa la conexion con la base de datos
    include("../conexion.php");
    $obj = file_get_contents("php://input");
    $json=json_decode($obj);
    //se declara el query
    $query="SELECT pp.nombre_producto,pp.cantidad,pp.cantidad*p.precio  AS total,p.nombre_categoria FROM PP as pp inner join productos as p on pp.id_pedido='$json->id_pedido' and p.nombre_producto=pp.nombre_producto";
    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
    $result=pg_query($con,$query)or die("Error de consulta");
    //se cierra la conexion ya que los datos se guardaron en la variable $result
    pg_close($con);
    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
    $respuesta=pg_fetch_all($result);
    // json_encode se encarga de convertir el array en un json(java script object notation)
    echo json_encode($respuesta);
}
function updatePedidos(){
    //se importa la conexion con la base de datos
    include("../conexion.php");
    //decodifica un string a json
    $obj = json_decode(file_get_contents("php://input"));
    //query de la consulta a la base de datos
    $query = "SELECT modificarPedido('$obj->id_pedido','$obj->estado');";
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
function updatePedidosR(){
    //se importa la conexion con la base de datos
    include("../conexion.php");
    //decodifica un string a json
    $obj = json_decode(file_get_contents("php://input"));
    //query de la consulta a la base de datos
    $query = "SELECT modificarPedidoR('$obj->id_pedido','$obj->estado','$obj->detalle');";
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
function putPedido(){
    //se importa la conexion con la base de datos
    include("../conexion.php");
    $obj = file_get_contents("php://input");
    $json=json_decode($obj);
    //se declara el query
    $query="SELECT insertarPedido('$json->nombre_usuario')";
    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
    $result=pg_query($con,$query)or die("Error de consulta");
    //se cierra la conexion ya que los datos se guardaron en la variable $result
    pg_close($con);
    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
    $respuesta=pg_fetch_all($result);
    // json_encode se encarga de convertir el array en un json(java script object notation)
    echo json_encode($respuesta);
}
function putPP(){
    //se importa la conexion con la base de datos
    include("../conexion.php");
    //decodifica un string a json
    $obj = json_decode(file_get_contents("php://input"));
    //query de la consulta a la base de datos
    $query = "SELECT insertarProductoapedido('$obj->nombre_producto','$obj->id_pedido','$obj->cantidad');";
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