define ['../articles.module'], (articles) ->
	'use strict'
	articles.controller 'ArticleDocumentController', [
		'$scope'
		'$state'
		'$stateParams'
		'Restangular'
		($scope, $state, $stateParams, Restangular) ->
			$scope.article = {}

			Restangular
			.one 'articles', $stateParams.id
			.get()
			.then (article) ->
				$scope.article = article
			, (err) -> throw err
			
			$scope.update = ->
				$scope.article.put().then (article) ->
					$state.go 'articles.collection'
	]












			# saveDocument = ->
			# 	promise = do $scope.article.put
			# 	promise.then (article) ->
			# 		$state.go 'article.collection'

			# loadArticleTags = (query) ->
			# 	regexp = new RegExp query, 'i'
			# 	promise = $http.get API_URL + '/articles', params: name: do regexp.toString
			# 	return promise

			# article = Restangular.one 'articles', $stateParams.articleId
			# promise = do article.get
			# promise.then (article) ->
			# 	$scope.article = article
			# 	$scope.$watch 'article.currency', (newval, oldval) ->
			# 		if newval isnt 'YE' then delete $scope.article.yevalue

			# $scope.saveDocument = saveDocument
			# $scope.loadArticleTags = loadArticleTags
			# $scope.id = $stateParams.articleId
	# ]