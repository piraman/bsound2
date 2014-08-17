define [
	'angular'
	'contextmenu'
	'ngtagsinput'
	'restangular'
	'textangular'
	'textangularsanitize'
	'uibootstraptemplates'
], (angular) ->
	'use strict'
	products = angular.module 'app.products', [
		'ng-context-menu'
		'ngTagsInput'
		'restangular'
		'textAngular'
		'ui.bootstrap'
		'ui.router'
	]
	products.config [
		'$stateProvider'
		($stateProvider) ->
			$stateProvider
			.state 'products',
				abstract: yes
				template: '<ui-view class=\'products-container\'></ui-view>'
				url: '/products'
			.state 'products.collection',
				templateUrl: './app/modules/products/templates/products.collection.template.html'
				controller: 'ProductCollectionController'
				url: ''
			.state 'products.document',
				templateUrl: './app/modules/products/templates/products.document.template.html'
				controller: 'ProductDocumentController'
				url: '/{id:[0-9a-z]{24,24}}'
			.state 'products.create',
				templateUrl: './app/modules/products/templates/products.create.template.html'
				controller: 'ProductCreateController'
				url: '/create'
	]
	return products