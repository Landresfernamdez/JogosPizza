
'use strict'
angular.module('userModule')
.controller('productosController',function($scope,OperationsProductos,$location,$route){
   $scope.categoria={
       nombre_categoria:""
   }
   $scope.producto={
       nombre_producto:"",
       precio:"",
       estado:"",
       nombre_categoria:""
   }
    $scope.getCategorias= function getCategorias(){
        OperationsProductos.getCategorias(function(res){
            $scope.listaCategorias = res;
        });
    };
    $scope.getCategorias();
    $scope.getProductos= function getProductos(){
        OperationsProductos.getProductos({nombre_categoria:selectedOption.text},function(res){
            $scope.listaProductos = res;
        });
    };
    var select = document.getElementById('s_categoria');
    var selectedOption;
    select.addEventListener('change',
        function(){
            selectedOption = this.options[select.selectedIndex];
            $scope.getProductos();
        });

});
