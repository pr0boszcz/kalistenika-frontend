
app = angular.module "app"
delay = (ms, func) -> setTimeout func, ms
app.controller 'FormularzController', ($scope, $http, parallaxHelper, $document, Exercises, Trainings ) ->
  $scope.background = parallaxHelper.createAnimator -0.3, 500, 0, 0
  $scope.list1 = [{"name":"offline1"}, {"name":"offline2"}, {"name":"offline3"}]
  $scope.list2 = []
  $scope.plans = []
  $scope.training = {"id":null}
  $scope.trainings = []

  # zapytanie do serwera
  # za pomocą resource $resource
  $scope.list1 = Exercises.query()
  $scope.trainings = Trainings.query()
  #$scope.plans = Resources.plans.query()

  # Configi dla list sortowalnych
  $scope.list1config =
    group:
      name: "exercises",
      pull: "clone",
      put: false,
    animation: 150,
    disabled: false,
    sort: false,
    scroll: true,

  $scope.list2config =
    group: "exercises",
    animation: 150,

  $scope.show = (tr) ->
    $scope.list2 = []
    tmptr = Trainings.get id: tr.id, ->
      for serie in tmptr.series
        newitem = {"name":serie.exercise.name, "id":serie.exercise_id, "repeats":serie.repeats}
        $scope.list2.push newitem
      $scope.training.name = tmptr.name
      $scope.training.level = tmptr.level
      $scope.training.pause = tmptr.pause
      $scope.training.id = tmptr.id

  # flaga dla guzika do usuwania z listy exercisa (jakieś badziewie o.0)
  this.hoverEdit = true

  $scope.hoverIn = ->
    this.hoverEdit = true

  $scope.hoverOut = ->
    this.hoverEdit = false

  $scope.removeSerie = (item) ->
    $scope.list2.splice(item, 1)

  $scope.reset_form = ->
    $scope.training.name = ''
    $scope.training.level = ''
    $scope.training.pause = ''
    $scope.list2 = []
    $scope.training.id = null

  $scope.delete = (item) ->
    tmptr = Trainings.get id: item.id, ->
      tmptr.$remove()
    $scope.reset_form()
    delay 150, ->
      $scope.trainings = Trainings.query()

  $scope.clone = (serie) ->
    newitem = {"name":serie.name, "id":serie.id }
    $scope.list2.push newitem


  # save
  $scope.save = ->
    series_attributes = []
    for i in $scope.list2
      series_attributes.push
        "repeats": i.repeats,
        "exercise_id": i.id

    if $scope.training.id == null
      $scope.training.series_attributes = series_attributes
      trainingResource = new Trainings()
      trainingResource.training = $scope.training
      trainingResource.$save()
    else
      tmptr = Trainings.get id: $scope.training.id, ->
        tmptr.series_attributes = series_attributes
        tmptr.name = $scope.training.name
        tmptr.level = $scope.training.level
        tmptr.pause = $scope.training.pause
        tmptr.$update()

    delay 150, ->
      $scope.trainings = Trainings.query()
