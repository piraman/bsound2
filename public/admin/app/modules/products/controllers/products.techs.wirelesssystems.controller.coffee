define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsWirelessSystemsController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Количество каналов', '']
				['Радиочастота', '']
				['Направленность', '']
				['Чувствительность', '']
				['Частотный диапазон', '']
				['Выход', '']
				['Цвет', '']
				['Вес', '']
				['Габариты', '']
				['Страна производитель', '']
				['Питание и потребление', '']
			]
	]