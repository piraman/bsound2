define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsLowImpedanceAmplifierController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Количество каналов', '']
				['Мощность', '']
				['Импеданс', '']
				['Частотный диапазон', '']
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