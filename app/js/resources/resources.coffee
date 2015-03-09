app = angular.module("app")

app.factory "Trainings", ($resource) ->
  $resource '/trainings/:id.json', {id: '@id'},
    update:
      method: 'PUT'

app.factory "Exercises", ($q, $resource) ->
  $resource '/exercises.json'

app.factory "Plans", ($q, $resource) ->
  $resource '/plans.json'

app.factory "Plan", ($q, $resource) ->
  $resource '/plans/:id.json'
