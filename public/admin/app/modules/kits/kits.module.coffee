define [
	'angular'
	'uirouter'
	'restangular'
	'uitree'
	'ngtagsinput'
], (angular) ->
	'use strict'
	kits = angular.module 'app.kits', [
		'ui.router'
		'restangular'
		'ui.tree'
		'ngTagsInput'
	]
	kits.config [
		'$stateProvider'
		($stateProvider) ->
			$stateProvider
			.state 'kits',
				controller: 'KitsController'
				templateUrl: './app/modules/kits/templates/kits.template.html'
				url: '/kits'
	]
	return kits