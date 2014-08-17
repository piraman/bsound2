define ['../reports.module'], (reports) ->
	'use strict'
	reports.controller 'ReportCreateController', [
		'$scope'
		'$state'
		'Restangular'
		($scope, $state, Restangular) ->
			# common init
			$scope.report = {}
			$scope.create = ->
				Restangular
				.all 'reports'
				.post $scope.report
				.then (report) ->
					$state.go 'reports.collection'
				, (err) -> throw err
	]
			# saveDocument = ->
			# 	promise = reports.post $scope.report
			# 	promise.then (report) ->
			# 		$state.go 'report.collection'

			# loadReportTags = (query) ->
			# 	regexp = new RegExp query, 'i'
			# 	promise = $http.get API_URL + '/reports', params: name: do regexp.toString
			# 	return promise

			# reports = Restangular.all 'reports'

			# $scope.report = {}
			# $scope.saveDocument = saveDocument
			# $scope.loadReportTags = loadReportTags

			# $scope.$watch 'report.type', (newval, oldval) ->
			# 	unless newval then delete $scope.report.techs
			# $scope.$watch 'report.currency', (newval, oldval) ->
			# 	if newval isnt 'YE' then delete $scope.report.yevalue
	