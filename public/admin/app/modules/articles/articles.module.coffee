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
	articles = angular.module 'app.articles', [
		'ng-context-menu'
		'ngTagsInput'
		'restangular'
		'textAngular'
		'ui.bootstrap'
		'ui.router'
	]
	articles.config [
		'$stateProvider'
		($stateProvider) ->
			$stateProvider
			.state 'articles',
				abstract: yes
				template: '<ui-view class=\'articles-container\'></ui-view>'
				url: '/articles'
			.state 'articles.collection',
				templateUrl: './app/modules/articles/templates/articles.collection.template.html'
				controller: 'ArticlesCollectionController'
				url: ''
			.state 'articles.document',
				templateUrl: './app/modules/articles/templates/articles.document.template.html'
				controller: 'ArticlesDocumentController'
				url: '/{article:[0-9a-z]{24,24}}'
			.state 'articles.create',
				templateUrl: './app/modules/articles/templates/articles.create.template.html'
				controller: 'ArticlesCreateController'
				url: '/create'
	]
	return articles