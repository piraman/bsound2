define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsLoudspeackersController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs
				$scope.product.techs = [
					['Артикул', '']
					['Тип', '']
					['Встроенный усилитель', '']
					['Входы', '']
					['Диаметр диффузора', '']
					['Мощность', '']
					['Вес', '']
					['Цвет', '']
				]
	]