angular.module('userModule',['ngRoute'])
.config(['$routeProvider',function($routeProvider)
    {
        $routeProvider
                    .when("/pedidos",{
                        templateUrl:'pedidos/pedidos.html',
                        controller: 'pedidosController'
                    })
			        .otherwise({
			            redirectTo: '/'
			        });
    }
]);