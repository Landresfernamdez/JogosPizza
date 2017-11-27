'use strict'
angular.module('userModule')
    .factory('OperationsComprador',function($http,$location){

        var urlp="http://172.24.47.10:8080/JogosPizza/server/usuarios/CRUDusuarios.php?Funcion=";

        var respuesta= {

            getUsuario: function(usuario,callback){

                $http({
                    method  :'POST',
                    url     : urlp+"getDataUser",
                    data    : usuario
                })
                    .success(function(data){
                        callback(data);
                    }).error(function(data) {
                        mostrarNotificacion("Error de conexion,revise su conexion a Internet", 1);
                });
            },
            modificarUsuario: function(usuario,callback){
                $http({
                    method  : 'POST',
                    url     : urlp+"modificarDatos",
                    data    : usuario

                })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor

                    .then(function mySuccess(response) {
                        if(response.data.status){
                            mostrarNotificacion("Se modifico con exito",2);
                            callback({success: true});
                        }
                        else{
                            mostrarNotificacion("Error en la modificacion",1);
                            console.log(response);
                            callback({success: false});
                        }
                    },function myError(response){
                        mostrarNotificacion("Revise su conexion a Internet",1);
                        callback({success: false});
                    });

            }

        };
        return respuesta;
    });
