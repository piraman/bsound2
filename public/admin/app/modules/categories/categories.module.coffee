define [
	'angular'
	'uirouter'
	'restangular'
	'uitree'
	'ngtagsinput'
], (angular) ->
	'use strict'
	categories = angular.module 'app.categories', [
		'ui.router'
		'restangular'
		'ui.tree'
		'ngTagsInput'
	]
	categories.config [
		'$stateProvider'
		($stateProvider) ->
			$stateProvider
			.state 'categories',
				controller: 'CategoriesController'
				templateUrl: './app/modules/categories/templates/categories.template.html'
				url: '/categories'
	]
	return categories