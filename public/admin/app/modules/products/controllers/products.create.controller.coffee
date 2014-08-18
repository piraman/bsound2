define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductCreateController', [
		'$scope'
		'$state'
		'$http'
		'Restangular'
		'API_URL'
		($scope, $state, $http, Restangular, API_URL) ->
			products = Restangular.all 'products'
			# common init
			$scope.product = {}
			$scope.create = ->
				products
				.post $scope.product
				.then (product) ->
					$state.go 'products.collection'
				, (err) -> throw err

			$scope.load = (query) -> products.getList 'name*': query
			# $scope.load = (query) ->
			# 	regexp = new RegExp query, 'i'
			# 	promise = $http.get API_URL + '/products', params: name: do regexp.toString
			# 	return promise
	]
			# saveDocument = ->
			# 	promise = products.post $scope.product
			# 	promise.then (product) ->
			# 		$state.go 'product.collection'

			# loadProductTags = (query) ->
			# 	regexp = new RegExp query, 'i'
			# 	promise = $http.get API_URL + '/products', params: name: do regexp.toString
			# 	return promise

			# products = Restangular.all 'products'

			# $scope.product = {}
			# $scope.saveDocument = saveDocument
			# $scope.loadProductTags = loadProductTags

			# $scope.$watch 'product.type', (newval, oldval) ->
			# 	unless newval then delete $scope.product.techs
			# $scope.$watch 'product.currency', (newval, oldval) ->
			# 	if newval isnt 'YE' then delete $scope.product.yevalue
	