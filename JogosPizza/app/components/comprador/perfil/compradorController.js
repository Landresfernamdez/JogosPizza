
'use strict'
angular.module('userModule')
.controller('compradorController',function($scope,OperationsComprador){
    $scope.usuario={
        nombre_usuario:"",
        nombre:"",
        apellido1:"",
        apellido2:"",
        provincia:"",
        canton:"",
        distrito:"",
        detalle:"",
        contrasena:""
    };
    var user = sessionStorage.getItem("nombre_usuario");

    $scope.obtenerUsuario= function(){
        $scope.usuario.nombre_usuario = user;
        OperationsComprador.getUsuario($scope.usuario,function(res){
            $scope.listaUsuario = res;
            console.log($scope.listaUsuario);
        });
    };
    $scope.modificarUsuario = function  (usuario) {
        $scope.usuario.nombre_usuario = user;
        $scope.usuario.nombre = usuario.nombre;
        $scope.usuario.apellido1 = usuario.apellido1;
        $scope.usuario.apellido2 = usuario.apellido2;
        $scope.usuario.distrito = usuario.distrito;
        $scope.usuario.canton = usuario.canton;
        $scope.usuario.provincia = usuario.provincia;
        $scope.usuario.detalle = usuario.detalle;
        $scope.usuario.contrasena = usuario.contrasena;
        OperationsComprador.modificarUsuario($scope.usuario,function (response) {
            if (response.success) {
            }
        });
    }



});
