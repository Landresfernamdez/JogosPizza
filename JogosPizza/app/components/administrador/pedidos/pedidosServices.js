'use strict'
angular.module('userModule')
    .factory('OperationsPedidos',function($http,$location){
        var urlp="http://localhost:8080/JogosPizza/server/pedidos/CRUDpedidos.php?Funcion=";
        var respuesta={
            getPedidos: function(callback){
                $http.get(
                    urlp+"ObtenertodosPedidos"
                ).success(function successCallback(response){
                    callback(response);
                }).error(function errorCallback(response) {
                    //En caso de fallo en la peticion entra en esta funcion
                    callback(response);
                });
            },
            getDetalles:function(callback){
                $http.get(
                    urlp+"ObtenertodosDetallesPedido"
                ).success(function successCallback(response){
                    callback(response);
                }).error(function errorCallback(response){
                    //En caso de fallo en la peticion entra en esta funcion
                    callback(response);
                });
            }
        }
        return respuesta;
    });
