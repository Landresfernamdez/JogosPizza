angular.module('userModule',['ngRoute'])
.config(['$routeProvider',function($routeProvider)
    {
        $routeProvider
                    .when("/comprador",{
                    	templateUrl:'comprador/comprador.html',
                        controller: 'compradorController'
                    })
			        .otherwise({
			            redirectTo: '/'
			        });
    }
]);