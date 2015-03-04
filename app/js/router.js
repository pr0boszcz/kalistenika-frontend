angular.module("app").config(function($routeProvider, $locationProvider) {

  //$locationProvider.html5Mode({enabled:true});

  $routeProvider.when('/login', {
    templateUrl: 'login.html',
    controller: 'LoginController'
  });

  $routeProvider.when('/home', {
    templateUrl: 'home.html',
    controller: 'HomeController'
  });

  $routeProvider.when('/frontpage', {
    templateUrl: 'frontpage.html',
    controller: 'FormularzController',
    
    //// jeśli za pomocą service $http (wiecej w controllerze)
    // 
    // resolve: {
    //   exercises: function(ExerciseService) {
    //     return ExerciseService.getExercises();
    //   }
    // }
  });

  $routeProvider.otherwise({ redirectTo: '/frontpage' });

});
