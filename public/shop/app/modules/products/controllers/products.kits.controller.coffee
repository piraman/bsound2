define ['../products.module'], (products) ->

	products.controller 'ProductsKitsController', [
		'$scope'
		'$state'
		'$stateParams'
		'Restangular'
		($scope, $state, $stateParams, Restangular) ->

			$scope.base = location.origin

			Restangular
				.one 'kits'
				.get()
				.then (kits) ->

					populateProducts = (kit) ->

						ids = []
						for value, i in kit.products then ids.push value._id

						Restangular
							.all 'products'
							.getList ids: ids.join ','
							.then (products) ->

								kit.products = products
								$scope.kit = kit

					walk = (tree) ->

						for value, i in tree
							if value.id is $stateParams.kit then populateProducts value
							else walk value.kits

					walk kits.tree
	]