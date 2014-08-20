define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsPreamplifiersController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Количество каналов', '']
				['Частотный диапозон', '']
				['Регуляторы', '']
				['Входы', '']
				['Выходы', '']
				['Рэковое крепление', '']
				['Цвет', '']
				['Вес', '']
				['Габариты', '']
				['Страна производитель', '']
				['Питание и потребление', '']
			]
	]