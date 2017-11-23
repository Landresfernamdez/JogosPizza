
'use strict'
angular.module('userModule')
.controller('pedidosController',function($scope,OperationsPedidos,$location,$route){
    $scope.pedido={
        nombre_usuario:'',
        id_pedido:'',
        estado:'',
        fecha:''
    }
    $scope.getPedidos= function getPedidos() {
        OperationsPedidos.getPedidos( function(res) {
            $scope.listaPedidos = res;
            console.log(res);
        });
    };
    $scope.verDetalles=function verDetalles(id){
        OperationsPedidos.getDetalles(id,function(res) {
            $scope.listaDetalles = res;
            console.log(res);
        });
    }
    $scope.getPedidos();
});
