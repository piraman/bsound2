define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsControllersSpeackersController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Количество каналов', '']
				['Функции', '']
				['Функциональные кнопки', '']
				['Частотный диапазон', '']
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