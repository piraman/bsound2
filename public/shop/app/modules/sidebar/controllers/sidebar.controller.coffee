define ['../sidebar.module'], (sidebar) ->
	'use strict'
	sidebar.controller 'SidebarController', [
		'$scope'
		'Restangular'
		($scope, Restangular) ->
			Restangular
				.one 'categories'
				.get()
				.then (categories) -> 
					$scope.categories = categories
			Restangular
				.one 'kits'
				.get()
				.then (kits) -> 
					$scope.kits = kits
			# promise = $http.get API_URL + '/settings'
			# promise.success (settings) ->
			# 	$scope.menutree = settings[0].menutree
			# $scope.toggle = (scope) ->
			# 	scope.$parent.collapsed = !scope.$parent.collapsed
	]
