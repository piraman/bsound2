define ['../reports.module'], (reports) ->
	'use strict'
	reports.controller 'ReportDocumentController', [
		'$scope'
		'$state'
		'$stateParams'
		'Restangular'
		($scope, $state, $stateParams, Restangular) ->
			$scope.report = {}

			Restangular
			.one 'reports', $stateParams.id
			.get()
			.then (report) ->
				$scope.report = report
			, (err) -> throw err
			
			$scope.update = ->
				$scope.report.put().then (report) ->
					$state.go 'reports.collection'
	]












			# saveDocument = ->
			# 	promise = do $scope.report.put
			# 	promise.then (report) ->
			# 		$state.go 'report.collection'

			# loadReportTags = (query) ->
			# 	regexp = new RegExp query, 'i'
			# 	promise = $http.get API_URL + '/reports', params: name: do regexp.toString
			# 	return promise

			# report = Restangular.one 'reports', $stateParams.reportId
			# promise = do report.get
			# promise.then (report) ->
			# 	$scope.report = report
			# 	$scope.$watch 'report.currency', (newval, oldval) ->
			# 		if newval isnt 'YE' then delete $scope.report.yevalue

			# $scope.saveDocument = saveDocument
			# $scope.loadReportTags = loadReportTags
			# $scope.id = $stateParams.reportId
	# ]