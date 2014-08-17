define ['../products.module'], (products) ->
	'use strict'
	products.controller 'ProductCollectionController', [
		'$scope'
		'$state'
		'Restangular'
		($scope, $state, Restangular) ->
			$scope.pagination = max: 5, total: null, pages: null, current: null
			$scope.selected = null
			$scope.products = []

			Restangular
			.all 'products'
			.getList()
			.then (products) ->
				products.meta = fields: ['name'], fieldnames: ['Нименование']
				$scope.products = products
			, (err) -> throw err

			$scope.create = -> $state.go 'products.create'
			$scope.read = (index) -> $state.go 'products.document', id: $scope.products[index]._id
			$scope.readSelected = -> $state.go 'products.document', id: $scope.products[$scope.selected]._id
			$scope.delete = (index) -> $scope.products[index].remove().then -> $state.transitionTo $state.current, {}, reload: yes, inherit: no, notify: yes
			$scope.deleteSelected = -> $scope.products[$scope.selected].remove().then -> $state.transitionTo $state.current, {}, reload: yes, inherit: no, notify: yes
			$scope.toggle = (index) -> if $scope.selected is index then $scope.selected = !$scope.selected else $scope.selected = index
	]

