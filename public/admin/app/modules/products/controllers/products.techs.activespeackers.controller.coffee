define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsActiveSpeackersController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Встроенный усилитель', '']
				['Входы', '']
				['Выходы', '']
				['Диаметр диффузора', '']
				['Мощность', '']
				['Импеданс', '']
				['Звуковое давление', '']
				['Частотный диапозон', '']
				['Материал корпуса', '']
				['Цвет', '']
				['Вес', '']
				['Габариты', '']
				['Страна производитель', '']
				['Питание и потребление', '']
			]
	]