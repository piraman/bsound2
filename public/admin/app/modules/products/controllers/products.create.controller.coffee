define ['../products.module'], (product) ->

	product.controller 'ProductCreateController', [
		'$scope'
		'$state'
		'Restangular'
		($scope, $state, Restangular) ->

			productsManager = Restangular.all 'products'
			$scope.product = {}

			$scope.load = (query) -> productsManager.getList 'name*': query
			$scope.create = ->

				if $scope.product.related.length?
					related = []
					for value, i in $scope.product.related then related.push value._id
					$scope.product.related = related

				productsManager
					.post $scope.product
					.then -> $state.go 'products.collection'

			$scope.productTypeSwitch = ->
				$scope.product.techs = null
	]