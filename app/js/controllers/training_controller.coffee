app = angular.module "app"
delay = (ms, func) -> setTimeout func, ms
app.controller 'TrainingController', ($scope, $http, $routeParams, parallaxHelper, $document, Exercises, Trainings ) ->
  $scope.time = 0
  $isTimerRun = false
  tmptr = Trainings.get id: $routeParams.id, ->
    $scope.pause = tmptr.pause
    $scope.time = tmptr.pause

  $scope.startTimer= ->
    if $isTimerRun
      return
    else
      $isTimerRun = true
      $scope.startCounting()

  $scope.startCounting= ->
    delay 1000, ->
      $scope.time--
      $scope.timerData=
        percentage: parseFloat($scope.time/$scope.pause)
        label:      $scope.time
      $scope.$apply()
      if $scope.time > 0
        $scope.startCounting()
      else
        $scope.resetTimer()
        return

  $scope.resetTimer= ->
    $scope.time = $scope.pause
    $isTimerRun = false
