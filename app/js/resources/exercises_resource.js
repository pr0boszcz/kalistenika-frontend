angular.module("app").factory("ExercisesResource", function ($q, $resource) {
  return $resource('/exercises.json');
});
