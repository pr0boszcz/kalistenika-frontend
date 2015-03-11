angular.module("app", [
  "ngResource",
  "ngRoute",
  "ng-sortable",
  "duParallax",
  "duScroll",
  //  "angular.directives-round-progress",
  "angular-svg-round-progress"

  ]).run(function($rootScope) {
  // adds some basic utilities to the $rootScope for debugging purposes
  $rootScope.log = function(thing) {
    console.log(thing);
  };

  $rootScope.alert = function(thing) {
    alert(thing);
  };
});
