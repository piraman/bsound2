define ['../sidebar.module'], (sidebar) ->

	sidebar.controller 'SidebarController', [
		'$scope'
		'$sce'
		'Restangular'
		($scope, $sce, Restangular) ->

			base = location.origin

			Restangular
				.one 'categories'
				.get().then (categories) -> $scope.categories = categories

			Restangular
				.one 'kits'
				.get().then (kits) -> $scope.kits = kits

			Restangular
				.all 'reports'
				.getList().then (reports) ->
					for value, i in reports
						value.safe =
							text: $sce.trustAsHtml value.text
							pictures:
								main: "#{base}/pictures/#{value.pictures.main}"
					$scope.reports = reports

			Restangular
				.all 'articles'
				.getList().then (articles) ->
					for value, i in articles
						value.safe =
							text: $sce.trustAsHtml value.text
							pictures:
								main: "#{base}/pictures/#{value.pictures.main}"
					$scope.articles = articles
	]
