define ['../products.module'], (products) ->
	'use strict'
	products.controller 'ProductsCollectionController', [
		'$scope'
		'$http'
		'Restangular'
		($scope, $http, Restangular) ->
			$scope.baseurl = -> location.origin
			products = Restangular.all 'products'
			promise = do products.getList
			promise.then (products) ->
				$scope.products = products
	]