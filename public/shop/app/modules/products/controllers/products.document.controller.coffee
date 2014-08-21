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
		'US'
		'EU'
		'YE'
		($scope, Restangular, $state, $stateParams, $sce, US, EU, YE) ->


			$scope.currencies =
				US: US
				EU: EU
				YE: YE

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

					for value, i in product.pictures.other then product.safe.pictures.other.push "#{base}/pictures/#{value}"

					related = angular.copy product.related
					for value, i in related then value.pictures.main = "#{base}/pictures/#{value.pictures.main}"
					product.safe.related = related
					$scope.product = product

			$scope.toggleShowFull = -> $scope.showFull = !$scope.showFull
	]