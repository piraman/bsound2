define ['../products.module'], (products) ->
	'use strict'
	products.controller 'ProductsDocumentController', [
		'$scope'
		'$http'
		'Restangular'
		'$state'
		'$stateParams'
		'$sce'
		($scope, $http, Restangular, $state, $stateParams, $sce) ->
			$scope.baseurl = -> location.origin
			product = Restangular.one 'products', $stateParams.product
			promise = do product.get
			promise.then (product) ->
				$scope.showFull = false
				$scope.toggleShowFull = ->
					$scope.showFull = !$scope.showFull
				# product.overview = $sce.trustAsHtml product.overview
				$scope.product = product
				$scope.product.overviewSafe = $sce.trustAsHtml $scope.product.overview
				$scope.product.description.shortSafe = $sce.trustAsHtml $scope.product.description.short
				$scope.product.description.fullSafe = $sce.trustAsHtml $scope.product.description.full
	]