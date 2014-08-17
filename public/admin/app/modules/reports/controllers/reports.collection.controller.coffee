define ['../reports.module'], (reports) ->
	'use strict'
	reports.controller 'ReportCollectionController', [
		'$scope'
		'$state'
		'Restangular'
		($scope, $state, Restangular) ->
			$scope.pagination = max: 5, total: null, pages: null, current: null
			$scope.selected = null
			$scope.reports = []

			Restangular
			.all 'reports'
			.getList()
			.then (reports) ->
				reports.meta = fields: ['title'], fieldnames: ['Заголовок']
				$scope.reports = reports
			, (err) -> throw err

			$scope.create = -> $state.go 'reports.create'
			$scope.read = (index) -> $state.go 'reports.document', id: $scope.reports[index]._id
			$scope.readSelected = -> $state.go 'reports.document', id: $scope.reports[$scope.selected]._id
			$scope.delete = (index) -> $scope.reports[index].remove().then -> $state.transitionTo $state.current, {}, reload: yes, inherit: no, notify: yes
			$scope.deleteSelected = -> $scope.reports[$scope.selected].remove().then -> $state.transitionTo $state.current, {}, reload: yes, inherit: no, notify: yes
			$scope.toggle = (index) -> if $scope.selected is index then $scope.selected = !$scope.selected else $scope.selected = index
	]

