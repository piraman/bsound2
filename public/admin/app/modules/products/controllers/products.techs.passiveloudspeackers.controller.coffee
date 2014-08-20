define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsPassiveLoudspeackersController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Входы', '']
				['Выходы', '']
				['Диаметр диффузора', '']
				['Мощность', '']
				['Импеданс', '']
				['Звуковое давление', '']
				['Частотный диапозон', '']
				['Частота раздела кроссовера', '']
				['Материал корпуса', '']
				['Цвет', '']
				['Вес', '']
				['Габариты', '']
				['Страна производитель', '']
				['Питание и потребление', '']
			]
	]