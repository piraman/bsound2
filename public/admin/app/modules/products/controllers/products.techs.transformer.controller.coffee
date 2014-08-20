define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsTransformerController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Входы', '']
				['Выходы', '']
				['Вес', '']
				['Габариты', '']
				['Страна производитель', '']
			]
	]