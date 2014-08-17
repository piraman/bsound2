define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsSpeackersController', [
		'$scope'
		($scope) ->
			$scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Диаметр диффузора', '']
				['Звуковое давление', '']
				['Частотный диапозон', '']
				['Мощность', '']
				['Вес', '']
				['Цвет', '']
			]
	]