define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsMixersAmplifiersController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Количество каналов', '']
				['Мощность', '']
				['Импеданс', '']
				['Частотный диапазон', '']
				['Встроенный проигрыатель', '']
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