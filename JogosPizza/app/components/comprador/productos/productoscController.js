'use strict'
angular.module('userModule')
.controller('productoscController',function($scope,OperationscProductos,$location,$route){
   $scope.categoria={
       nombre_categoria:""
   }
   $scope.producto={
       nombre_producto:"",
       precio:"",
       estado:"",
       nombre_categoria:""
   }
   $scope.total=0;
    $scope.carrito=[];
    $scope.getCategorias= function getCategorias(){
        OperationscProductos.getCategorias(function(res){
            $scope.listaCategorias = res;
        });
    };
    $scope.realizarPedido=function realizarPedido(){
        console.log(sessionStorage.getItem("nombre_usuario"));
        if($scope.carrito.length>=1){
            OperationscProductos.addPedido({nombre_usuario:sessionStorage.getItem("nombre_usuario")},function(res){
               if(res.success){
                   var lista=$scope.carrito;
                   console.log(res.data.data[0].insertarpedido);
                   for(var x=0;x<lista.length;x++){
                       var json={nombre_producto:lista[x].nombre,id_pedido:res.data.data[0].insertarpedido,cantidad:lista[x].cantidad};
                       console.log(json);
                       OperationscProductos.addproductoPedido(json,function(res){


                       });
                   }
               }
            });
            console.log($scope.carrito);
            mostrarNotificacion("Su pedido se ha enviado con exito",2);
        }
        else{
            mostrarNotificacion("Debe agregar elementos al carro",1);
        }
    }
   $scope.agregar_a_carrito=function agregar_a_carrito(nombre,precio){
       if(document.getElementById(nombre).value!=""){
           var subtotal="";
           for(var y=0;y<precio.length;y++){
               if(subtotal[y]===','){
                   subtotal=subtotal.substr(0,y);
               }
               if(precio[y]==='.'){
                   subtotal=precio.substr(0,y)+precio.substr(y+1,precio.length-1);
               }
           }
           var counta=parseFloat(subtotal);
           $scope.total=$scope.total+(counta*document.getElementById(nombre).value);
           $scope.carrito.push({nombre:nombre,cantidad:document.getElementById(nombre).value,precio:counta})
           console.log($scope.carrito);
           mostrarNotificacion("Se agrego al carrito con exito",2);
       }
       else{
           mostrarNotificacion("Digite una cantidad",1);
       }
   }
    $scope.getCategorias();
    $scope.getProductos= function getProductos(){
        var category=localStorage.getItem("categoria");
        OperationscProductos.getProductos({nombre_categoria:category},function(res){
               $scope.listaProductos = res;
        });
    };
    var select1 = document.getElementById('c_categoria');
    var selectedOption1;
    select1.addEventListener('change',
        function(){
            selectedOption1 = this.options[select1.selectedIndex];
            localStorage.setItem("categoria",selectedOption1.text);
            $scope.getProductos();
        });
    $scope.actualizarProducto=function (producto) {
        $scope.producto=producto;
    }
});
