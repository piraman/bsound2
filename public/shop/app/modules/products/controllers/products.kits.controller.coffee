define ['../products.module'], (products) ->
	'use strict'
	products.controller 'ProductsKitsController', [
		'$scope'
		'$state'
		'$stateParams'
		'Restangular'
		($scope, $state, $stateParams, Restangular) ->
			Restangular
				.one 'kits'
				.get()
				.then (kits) ->
					walk = (tree) ->
						for value, i in tree
							if value.id is $stateParams.kit then $scope.kit = value
							else walk value.kits
					walk kits.tree
	]