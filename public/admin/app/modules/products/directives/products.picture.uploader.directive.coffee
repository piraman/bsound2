define [
	'./../products.module'
], (product) ->
	'use strict'
	product.directive 'pictureUploader', ->
		templateUrl: './app/modules/products/directives/products.picture.uploader.template.html'
		restrict: 'E'
		replace: yes
		require: 'ngModel'
		scope:
			multiple: '@pictureUploaderMultiple'
			model: '=ngModel'
			endpoint: '@pictureUploaderEndpoint'
		controller: ($scope, $http, API_URL) ->
			$scope.base = location.origin
			if do $scope.multiple.bool
				$scope.selected = []
				$scope.fileChange = (e) ->
					for file, i in e.files
						url = URL.createObjectURL file
						$scope.selected.push
							name: file.name
							url: url
							file: file
					do $scope.$apply
				$scope.cancel = (index) ->
					$scope.selected.splice index, 1
				$scope.upload = (index) ->
					file = $scope.selected[index].file
					form = new FormData()
					form.append 'other', file
					req = new XMLHttpRequest()
					req.onreadystatechange = (e) ->
						if @readyState is 4 and @status is 200
							$scope.model = JSON.parse e.target.response
							$scope.selected.splice index, 1
							do $scope.$apply
					req.open 'POST', API_URL + $scope.endpoint
					req.send form
				$scope.delete = (index) ->
					$http
					.delete API_URL + $scope.endpoint + '/' + $scope.model[index]
					.success (model) ->
						$scope.model = model
						# $scope.selected.splice index, 1
			else
				$scope.selected = null
				$scope.fileChange = (e) ->
					file = e.files[0]
					url = URL.createObjectURL file
					$scope.selected =
						name: file.name
						url: url
						file: file
					do $scope.$apply
					# $scope.$apply ->
					# 	$scope.selectedPicture =
					# 		name: file.name
					# 		url: url
					# 		file: file
				$scope.cancel = (index) ->
					$scope.selected = null
				$scope.upload = (index) ->
					file = $scope.selected.file
					form = new FormData()
					form.append 'main', file
					req = new XMLHttpRequest()
					req.onreadystatechange = (e) ->
						if @readyState is 4 and @status is 200
							$scope.model = JSON.parse e.target.response
							$scope.selected = null
							do $scope.$apply
					req.open 'POST', API_URL + $scope.endpoint
					req.send form
				$scope.delete = (index) ->
					$http
					.delete API_URL + $scope.endpoint
					.success (response) ->
						$scope.model = null
						$scope.selected = null