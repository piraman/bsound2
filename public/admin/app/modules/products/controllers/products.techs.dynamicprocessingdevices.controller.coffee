define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsDynamicProcessingDevicesController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Количество каналов', '']
				['Функциональные кнопки', '']
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