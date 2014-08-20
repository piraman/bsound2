define ['../products.module'], (products) ->

	products.controller 'ProductsCategoriesController', [
		'$scope'
		'$state'
		'$stateParams'
		'Restangular'
		($scope, $state, $stateParams, Restangular) ->

			$scope.base = location.origin

			Restangular
				.one 'categories'
				.get()
				.then (categories) ->

					populateProducts = (category) ->

						ids = []
						for value, i in category.products then ids.push value._id
						Restangular
							.all 'products'
							.getList ids: ids.join ','
							.then (products) ->
								category.products = products
								$scope.category = category

					walk = (tree) ->

						for value, i in tree
							if value.id is $stateParams.category then populateProducts value
							else walk value.categories

					walk categories.tree
					# $scope.categories = categories
				

			# $scope.baseurl = -> location.origin
			# promise = $http.get API_URL + '/settings'
			# promise.success (settings) ->
			# 	$scope.settings = settings
			# 	getCategory = (items, category, cb) ->
			# 		for value, i in items
			# 			if value.id is category then cb value
			# 			else getCategory value.items, category, cb
			# 	getCategoryProductsIds = (category) ->
			# 		ids = []
			# 		for product in category.products then ids.push product._id
			# 		ids
			# 	getCategory settings[0].menutree, $stateParams.category, (category) ->
			# 		ids = getCategoryProductsIds category
			# 		products = Restangular.all 'products'
			# 		promise = products.getList ids: ids.join ','
			# 		promise.then (products) ->
			# 			category.products = products
			# 			$scope.category = category
	]
