define [
	'angular'
	'./app.module'
], (angular) ->
	'use strict'
	require ['domready!'], (document) ->
		angular.bootstrap document, ['app']