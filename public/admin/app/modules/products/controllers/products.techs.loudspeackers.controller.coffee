define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsLoudspeackersController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Встроенный усилитель', '']
				['Входы', '']
				['Выходы', '']
				['Диаметр диффузора', '']
				['Диаметр отверстия для установки', '']
				['Мощность', '']
				['Импеданс', '']
				['Звуковое давление', '']
				['Частотный диапазон', '']
				['Частота раздела кроссовера', '']
				['Материал корпуса', '']
				['Цвет', '']
				['Вес', '']
				['Габариты', '']
				['Страна производитель', '']
				['Питание и потребление', '']
			]
	]