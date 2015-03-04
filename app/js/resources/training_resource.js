angular.module("app").factory("TrainingResource", function($q, $resource) {
  return $resource('/trainings');
});
