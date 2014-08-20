define ['../products.module'], (product) ->

	product.controller 'ProductDocumentController', [
		'$scope'
		'$state'
		'$stateParams'
		'Restangular'
		($scope, $state, $stateParams, Restangular) ->

			$scope.product = {}
			$scope.id = $stateParams.id
			products = Restangular.all 'products'

			Restangular
				.one 'products', $stateParams.id
				.get()
				.then (product) -> $scope.product = product
			
			$scope.load = (query) -> products.getList 'name*': query
			$scope.update = ->

				if $scope.product.related.length?
					related = []
					for value, i in $scope.product.related then related.push value._id
					$scope.product.related = related

				$scope.product.put().then (product) -> $state.go 'products.collection'

			$scope.productTypeSwitch = ->
				$scope.product.techs = null
	]












			# saveDocument = ->
			# 	promise = do $scope.product.put
			# 	promise.then (product) ->
			# 		$state.go 'product.collection'

			# loadProductTags = (query) ->
			# 	regexp = new RegExp query, 'i'
			# 	promise = $http.get API_URL + '/products', params: name: do regexp.toString
			# 	return promise

			# product = Restangular.one 'products', $stateParams.productId
			# promise = do product.get
			# promise.then (product) ->
			# 	$scope.product = product
			# 	$scope.$watch 'product.currency', (newval, oldval) ->
			# 		if newval isnt 'YE' then delete $scope.product.yevalue

			# $scope.saveDocument = saveDocument
			# $scope.loadProductTags = loadProductTags
			# $scope.id = $stateParams.productId
	# ]