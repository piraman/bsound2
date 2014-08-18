define [
	'angular'
	'restangular'
	'uirouter'
	# 'textangular'
	# 'textangularsanitize'
	# 'ngtagsinput'
], (angular) ->
	'use strict'
	products = angular.module 'app.products', [
		'ui.router'
		'restangular'
		# 'textAngular'
		# 'ngTagsInput'
	]
	products.config [
		'$stateProvider'
		($stateProvider) ->
			$stateProvider
				.state 'products',
					abstract: yes
					template: '<ui-view></ui-view>'
					url: '/products'
				# .state 'products.collection',
				# 	templateUrl: './app/modules/products/templates/products.collection.template.html'
				# 	controller: 'ProductsCollectionController'
				# 	url: ''
				.state 'products.categories',
					templateUrl: './app/modules/products/templates/products.categories.template.html'
					controller: 'ProductsCategoriesController'
					url: '/categories/:category'
				.state 'products.kits',
					templateUrl: './app/modules/products/templates/products.kits.template.html'
					controller: 'ProductsKitsController'
					url: '/kits/:kit'
				.state 'products.document',
					templateUrl: './app/modules/products/templates/products.document.template.html'
					controller: 'ProductsDocumentController'
					url: '/:product'
			# .state 'product.collection',
			# 	templateUrl: './app/modules/product/templates/product.collection.template.html'
			# 	controller: 'ProductCollectionController'
			# 	url: ''
			# .state 'product.document',
			# 	templateUrl: './app/modules/product/templates/product.document.template.html'
			# 	controller: 'ProductDocumentController'
			# 	url: '/{productId:[0-9a-z]{24,24}}'
			# .state 'product.create',
			# 	templateUrl: './app/modules/product/templates/product.create.template.html'
			# 	controller: 'ProductCreateController'
			# 	url: '/create'
	]
	return products