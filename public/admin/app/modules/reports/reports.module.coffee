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
	reports = angular.module 'app.reports', [
		'ng-context-menu'
		'ngTagsInput'
		'restangular'
		'textAngular'
		'ui.bootstrap'
		'ui.router'
	]
	reports.config [
		'$stateProvider'
		($stateProvider) ->
			$stateProvider
			.state 'reports',
				abstract: yes
				template: '<ui-view class=\'reports-container\'></ui-view>'
				url: '/reports'
			.state 'reports.collection',
				templateUrl: './app/modules/reports/templates/reports.collection.template.html'
				controller: 'ReportCollectionController'
				url: ''
			.state 'reports.document',
				templateUrl: './app/modules/reports/templates/reports.document.template.html'
				controller: 'ReportDocumentController'
				url: '/{id:[0-9a-z]{24,24}}'
			.state 'reports.create',
				templateUrl: './app/modules/reports/templates/reports.create.template.html'
				controller: 'ReportCreateController'
				url: '/create'
	]
	return reports