
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
    $scope.actualizarProducto=function (producto) {
        $scope.producto=producto;
    }
    $scope.postProducto = function postProducto(producto){
        if(producto.estado==='1'){
            producto.estado='0';
        }
        else if(producto.estado==='0'){
            producto.estado='1';
        }
        OperationsProductos.updateProductos(producto, function(response) {
            if (response.success){
            }
        });
    };
    var select1 = document.getElementById('s_categoria');
    var selectedOption1;
    select1.addEventListener('change',
        function(){
            selectedOption1 = this.options[select1.selectedIndex];
            $scope.getProductos();
        });
    $scope.modificarProducto = function modificarProducto(producto){
        $scope.producto.nombre_categoria=selectedOption1.text;
        OperationsProductos.modificarProductos($scope.producto, function(response) {
            if (response.success){
            }
        });
    };
    $scope.putProducto = function putProducto(producto){
        OperationsProductos.addProductos(producto, function(response) {
            if (response.success) {
                $location.path('productos');
                $route.reload();
            }
        });
    };
    $scope.deleteProducto = function deleteProducto(producto){
        OperationsProductos.deleteProductos($scope.producto, function(response) {
            if (response.success){
                $location.path('productos');
                $route.reload();
            }
        });
    };
});
