'use strict'
angular.module('userModule')
    .factory('OperationsProductos',function($http,$location){
        var urlp="http://172.24.47.10:8080/JogosPizza/server/productos/CRUDproductos.php?Funcion=";
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
            },
            deleteProductos: function(producto,callback){
                $http({
                    method  : 'POST',
                    url     : urlp+"deleteProducto",
                    data    : producto

                })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor
                    .then(function mySuccess(response) {
                        if(response.data.status){
                            mostrarNotificacion("Se elimino con exito",2);
                            callback({success: true});
                        }
                        else{
                            mostrarNotificacion("Introduzca los datos de forma correcta",1);
                        }
                    }, function myError(response) {
                        mostrarNotificacion("Revise su conexion a Internet",1);
                        callback({success: false});
                    });
            },
            addProductos: function(producto,callback){
                $http({
                    method  : 'POST',
                    url     : urlp+"putProducto",
                    data    : producto

                })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor
                    .then(function mySuccess(response) {
                        if(response.data.status){
                            mostrarNotificacion("Se agrego con exito",2);
                            callback({success: true});
                        }
                        else{
                            console.log(response);
                            mostrarNotificacion("Se agrego con exito",2);
                        }
                    }, function myError(response) {
                        mostrarNotificacion("Revise su conexion a Internet",1);
                        callback({success: false});
                    });
            },
            updateProductos: function(producto,callback){
                $http({
                    method  : 'POST',
                    url     : urlp+"postProducto",
                    data    : producto

                })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor
                    .then(function mySuccess(response) {
                        if(response.data.status){
                            if(producto.estado==='1'){
                                mostrarNotificacion("Se cambio el estado a activo con exito",2);
                            }
                            else if(producto.estado==='0'){
                                mostrarNotificacion("Se cambio el estado a inactivo con exito",2);
                            }
                            callback({success: true});
                        }
                        else{
                            mostrarNotificacion("Introduzca los datos de forma correcta",1);
                        }
                    }, function myError(response) {
                        mostrarNotificacion("Revise su conexion a Internet",1);
                        callback({success: false});
                    });
            },
            modificarProductos: function(producto,callback){
                $http({
                    method  : 'POST',
                    url     : urlp+"postallProducto",
                    data    : producto

                })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor
                    .then(function mySuccess(response) {
                        if(response.data.status){
                            if(producto.estado==='1'){
                                mostrarNotificacion("Se cambio el estado a activo con exito",2);
                            }
                            else if(producto.estado==='0'){
                                mostrarNotificacion("Se cambio el estado a inactivo con exito",2);
                            }
                            callback({success: true});
                        }
                        else{
                            mostrarNotificacion("Introduzca los datos de forma correcta",1);
                        }
                    }, function myError(response) {
                        mostrarNotificacion("Revise su conexion a Internet",1);
                        callback({success: false});
                    });
            }
        }
        return respuesta;
    });
