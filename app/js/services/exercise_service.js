angular.module("app").factory("ExerciseService", function($q, $http) {

  var getExercises = function() {
    return $http.get('/exercises.json');
  };

  return { getExercises: getExercises };
});
