define ['../products.module'], (products) ->

	products.controller 'ProductsKitsController', [
		'$scope'
		'$state'
		'$stateParams'
		'Restangular'
		'$sce'
		'US'
		'EU'
		'YE'
		($scope, $state, $stateParams, Restangular, $sce, US, EU, YE) ->

			$scope.currencies =
				US: US
				EU: EU
				YE: YE

			base = location.origin

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

								for value, i in products
									value.safe =
										pictures:
											main: "#{base}/pictures/#{value.pictures.main}"

								kit.products = products
								$scope.kit = kit

					walk = (tree) ->

						for value, i in tree
							if value.id is $stateParams.kit then populateProducts value
							else walk value.kits

					walk kits.tree
	]