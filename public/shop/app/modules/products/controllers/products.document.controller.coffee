define [
	'angular'
	'../products.module'
], (angular, products) ->

	products.controller 'ProductsDocumentController', [
		'$scope'
		'Restangular'
		'$state'
		'$stateParams'
		'$sce'
		($scope, Restangular, $state, $stateParams, $sce) ->

			base = location.origin
			$scope.showFull = no

			Restangular
				.one 'products', $stateParams.product
				.get().then (product) ->

					product.safe =
						overview: $sce.trustAsHtml product.overview
						description:
							short: $sce.trustAsHtml product.description.short
							full: $sce.trustAsHtml product.description.full
						pictures:
							main: "#{base}/pictures/#{product.pictures.main}"
							other: []
						related: []

					related = angular.copy product.related
					for value, i in related then value.pictures.main = "#{base}/pictures/#{value.pictures.main}"
					product.safe.related = related
					$scope.product = product

			$scope.toggleShowFull = -> $scope.showFull = !$scope.showFull
	]