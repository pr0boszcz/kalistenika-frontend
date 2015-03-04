angular.module("app").controller('FormularzController', function ($scope, $http, parallaxHelper, $document, ExercisesResource, TrainingResource) {

	$scope.background = parallaxHelper.createAnimator(-0.3, 500, 0, 0);

	$scope.list1 = [{"name":"offline1"}, {"name":"offline2"}, {"name":"offline3"}];
  $scope.list2 = [];
  $scope.training = {};

	//// zapytanie do serwera 
	// za pomocą resource $resource 
	$scope.list1 = ExercisesResource.query();
	
	//// za pomocą service $http 
	// $scope.list1 = exercises.data;

	//// bezpośrednio
	// $http.get('/exercises.json').then(function(res){
 	//    $scope.list1 = res.data;
 	// });

	// Configi dla list sortowalnych
	$scope.list1config = {
		group: {
			name: "exercises",
			pull: "clone",
			put: false,
		}, 
    		animation: 150,  
		disabled: false,
		sort: false,
	  	scroll: true,
	};


	$scope.list2config = {
		group: "exercises",  
		animation: 150,  
	};


	// flaga dla guzika do usuwania z listy exercisa (jakieś badziewie o.0)
	this.hoverEdit = true;

	$scope.hoverIn = function(){
    	this.hoverEdit = true;
	};

	$scope.hoverOut = function(){
    	this.hoverEdit = false;
	};

	$scope.removeSerie = function(item) {
		$scope.list2.splice(item, 1);
	};

	//save
	$scope.save = function() {
		var series_attributes = [];

		for ( var i in $scope.list2 ) {
			series_attributes.push({
				"repeats": $scope.list2[i].repeats, 
				"exercise_id": $scope.list2[i].id
			})
		};

		$scope.training.series_attributes = series_attributes;

		trainingResource = new TrainingResource();
		trainingResource.training = $scope.training ;
		trainingResource.$save();
	};
});
