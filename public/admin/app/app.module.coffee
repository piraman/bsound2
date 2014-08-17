define [
	# './modules/article/article.index'
	# './modules/category/category.index'
	# './modules/headbar/headbar.index'
	
	# './modules/news/news.index'
	# './modules/order/order.index'
	# './modules/product/product.index'
	# './modules/serie/serie.index'
	# './modules/user/user.index'
	# 'ngtagsinput'
	# 'textangularsanitize'
	'angular'
	'restangular'
	# 'uibootstraptemplates'
	'uirouter'
	# './modules/menu/menu.index'
	'./modules/kits/index'
	'./modules/products/index'
	'./modules/categories/index'
	'./modules/reports/index'
	'./modules/articles/index'
], (angular) ->
	'use strict'
	app = angular.module 'app', [
		# 'app.article'
		# 'app.category'
		# 'app.headbar'
		# 'app.menu'
		'app.categories'
		'app.kits'
		'app.reports'
		'app.articles'
		# 'app.news'
		# 'app.order'
		# 'app.serie'
		# 'app.user'
		# 'ngTagsInput'
		# 'app.menu'
		'app.products'
		'restangular'
		# 'ui.bootstrap'
		'ui.router'
	]
	app.constant 'API_URL', location.origin + '/api/v1'
	app.config [
		'$compileProvider'
		'$stateProvider'
		'$urlRouterProvider'
		'RestangularProvider'
		($compileProvider, $stateProvider, $urlRouterProvider, RestangularProvider) ->
			$compileProvider.imgSrcSanitizationWhitelist /^\s*(https?|ftp|file|blob):|data:image\//
			$urlRouterProvider.otherwise '/home'
			$stateProvider
			.state 'home',
				template: '<div>home page</div>'
				url: '/home'
			RestangularProvider.setBaseUrl location.origin + '/api/v1'
			RestangularProvider.setRestangularFields id: '_id'
	]
	return app