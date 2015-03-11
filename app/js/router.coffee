app = angular.module "app"

app.config ($routeProvider, $locationProvider) ->

  #$locationProvider.html5Mode enabled:true

  $routeProvider.when '/login',
    templateUrl: 'login.html',
    controller: 'LoginController'

  $routeProvider.when '/home',
    templateUrl: 'home.html',
    controller: 'HomeController'

  $routeProvider.when '/frontpage',
    templateUrl: 'frontpage.html',
    controller: 'FormularzController',

  $routeProvider.when '/training/:id',
    templateUrl: 'training.html',
    controller: 'TrainingController'

  $routeProvider.otherwise redirectTo: '/frontpage'
