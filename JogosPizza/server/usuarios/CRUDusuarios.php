<?php
if(function_exists($_REQUEST['Funcion'])){
    $_REQUEST['Funcion']();
}
else
{
    echo 'La funcion no ha sido creada: Comuniquese';
}
function validarusuario(){
    //se importa la conexion con la base de datos
    include("../conexion.php");
    //se declara el query
    $obj = file_get_contents("php://input");
    $json=json_decode($obj);
    $query="SELECT count(*) as counta FROM comprador as a inner join clientes as c on a.nombre_usuario='$json->nombre_usuario' and c.contrasena='$json->contrasena'";
    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
    $result=pg_query($con,$query)or die("Error de consulta");
    //se cierra la conexion ya que los datos se guardaron en la variable $result
    $row=pg_fetch_array($result);
    $contador=$row['counta'];
    pg_close($con);
    include("../conexion.php");
    $query1="SELECT count(*) as countar FROM administrador as a inner join clientes as c on a.nombre_usuario='$json->nombre_usuario' and c.contrasena='$json->contrasena'";
    //pg_query se encarga de ejecutar el query mediante la conexion y el query y  se encarga de realizar la consulta a la base y generar una tabla
    $result1=pg_query($con,$query1)or die("Error de consulta");
    //se cierra la conexion ya que los datos se guardaron en la variable $result
    $row1=pg_fetch_array($result1);
    $contador1=$row1['countar'];
    pg_close($con);
    if($contador>0){
        $arr =array(
                "success" => true,
                "tipo"=>"c"
                   );
        echo json_encode($arr);
    }
    else if($contador1>0){
        $arr =array(
            "success" => true,
            "tipo"=>"a"
        );
        echo json_encode($arr);
    }
    else{
        $arr =array(
            "success" => false
        );
        echo json_encode($arr);
    }
    //pg_fetch_all se encarga de retornar un array con filas y columnas de la tabla que se creo con el query
    //$respuesta=pg_fetch_all($result);
    // json_encode se encarga de convertir el array en un json(java script object notation)
   // echo json_encode($respuesta);
}
function putUsuarios(){
    //se importa la conexion con la base de datos
    include("../conexion.php");
    //decodifica un string a json
    $obj = file_get_contents("php://input");
    $json=json_decode($obj);
    $timestamp = date('Y-m-d G:i:s');
    //query de la consulta a la base de datos
    $query = "select insertarCliente('$json->nombre_usuario','$json->nombre','$json->apellido1',"
        . "'$json->apellido2','$json->distrito','$json->canton',"
        ."'$json->provincia','$json->detalle','$json->contrasena');";
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