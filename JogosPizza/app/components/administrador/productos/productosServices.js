'use strict'
angular.module('userModule')
    .factory('OperationsProductos',function($http,$location){
        var urlp="http://localhost:8080/JogosPizza/server/productos/CRUDproductos.php?Funcion=";
        var respuesta={
            getCategorias: function(callback){
            $http.get(
                urlp+"ObtenertodosCategorias"
            ).success(function successCallback(response){
                callback(response);
            }).error(function errorCallback(response) {
                mostrarNotificacion("Error de conexion,revise su conexion a Internet",1);
                //En caso de fallo en la peticion entra en esta funcion
                callback(response);
            });
        },
          getProductos: function(categoria,callback){
                $http({
                    method  :'POST',
                    url     : urlp+"ObtenertodosProductos",
                    data    : categoria

                })
                    .success(function(data){
                        callback(data);
                    }).error(function(data) {
                        mostrarNotificacion("Error de conexion,revise su conexion a Internet",1);
                });
            }
        }
        return respuesta;
    });
