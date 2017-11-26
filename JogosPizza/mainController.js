'use strict'
angular.module('userModule')
.controller('mainController',function($scope,$location,$route,$http){
    var urlp="http://172.24.47.10:8080/JogosPizza/server/usuarios/CRUDusuarios.php?Funcion=";
    $scope.usuario={
        nombre:"",
        apellido1:"",
        apellido2:"",
        contrasena:"",
        nombre_usuario:"",
        provincia:"",
        canton:"",
        distrito:"",
        detalle:""
    }
    $scope.datos_usuario={
        nombre_usuario:"",
        contrasena:""
    }
    $scope.validaUsuario=function(datos_usuario){
        $http({
            method  :'POST',
            url     : urlp+"validarusuario",
            data    : datos_usuario
        })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor
            .then(function mySuccess(response) {
                if(response.data.success){
                    if(response.data.tipo=='a'){
                        sessionStorage.setItem("nombre_usuario",datos_usuario.nombre_usuario)
                        window.location.href = ('app/components/administrador/administrador.html');
                    }
                    else if(response.data.tipo=='c'){
                        sessionStorage.setItem("nombre_usuario",datos_usuario.nombre_usuario)
                        window.location.href = ('app/components/comprador/comprador.html');
                    }
                    else{
                        mostrarNotificacion("Datos inconsistentes",1);
                    }
                }
                else{
                    console.log(response.data);
                    mostrarNotificacion("Datos inconsistentes",1);
                }
            }, function myError(response) {
                console.log(response);
                mostrarNotificacion("Revise su conexion a Internet",1);
            });
     }
     $scope.registrarUsuario=function(usuario){
        console.log(usuario);
         $http({
             method  :'POST',
             url     : urlp+"putUsuarios",
             data    : usuario
         })// si la insercion fue exitosa entra al succes de lo contrario retorna un error departe del servidor
             .then(function mySuccess(response){
                 if(response.data.status){
                     mostrarNotificacion("Se ha registrado con exito",2);
                 }
                 else{
                     console.log(response.data);
                     mostrarNotificacion("Ha ocurrido un error verifique los datos que ingreso",1);
                 }
             }, function myError(response) {
                 mostrarNotificacion("Revise su conexion a la red",1);
             });
     }
});

