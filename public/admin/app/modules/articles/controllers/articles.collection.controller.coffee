define ['../articles.module'], (articles) ->
	'use strict'
	articles.controller 'ArticleCollectionController', [
		'$scope'
		'$state'
		'Restangular'
		($scope, $state, Restangular) ->
			$scope.pagination = max: 5, total: null, pages: null, current: null
			$scope.selected = null
			$scope.articles = []

			Restangular
			.all 'articles'
			.getList()
			.then (articles) ->
				articles.meta = fields: ['title'], fieldnames: ['Заголовок']
				$scope.articles = articles
			, (err) -> throw err

			$scope.create = -> $state.go 'articles.create'
			$scope.read = (index) -> $state.go 'articles.document', id: $scope.articles[index]._id
			$scope.readSelected = -> $state.go 'articles.document', id: $scope.articles[$scope.selected]._id
			$scope.delete = (index) -> $scope.articles[index].remove().then -> $state.transitionTo $state.current, {}, reload: yes, inherit: no, notify: yes
			$scope.deleteSelected = -> $scope.articles[$scope.selected].remove().then -> $state.transitionTo $state.current, {}, reload: yes, inherit: no, notify: yes
			$scope.toggle = (index) -> if $scope.selected is index then $scope.selected = !$scope.selected else $scope.selected = index
	]

