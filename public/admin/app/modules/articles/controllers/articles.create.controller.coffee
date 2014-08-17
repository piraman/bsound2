define ['../articles.module'], (articles) ->
	'use strict'
	articles.controller 'ArticleCreateController', [
		'$scope'
		'$state'
		'Restangular'
		($scope, $state, Restangular) ->
			# common init
			$scope.article = {}
			$scope.create = ->
				Restangular
				.all 'articles'
				.post $scope.article
				.then (article) ->
					$state.go 'articles.collection'
				, (err) -> throw err
	]
			# saveDocument = ->
			# 	promise = articles.post $scope.article
			# 	promise.then (article) ->
			# 		$state.go 'article.collection'

			# loadArticleTags = (query) ->
			# 	regexp = new RegExp query, 'i'
			# 	promise = $http.get API_URL + '/articles', params: name: do regexp.toString
			# 	return promise

			# articles = Restangular.all 'articles'

			# $scope.article = {}
			# $scope.saveDocument = saveDocument
			# $scope.loadArticleTags = loadArticleTags

			# $scope.$watch 'article.type', (newval, oldval) ->
			# 	unless newval then delete $scope.article.techs
			# $scope.$watch 'article.currency', (newval, oldval) ->
			# 	if newval isnt 'YE' then delete $scope.article.yevalue
	