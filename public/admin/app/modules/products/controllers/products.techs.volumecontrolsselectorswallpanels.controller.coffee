define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsVolumeControlsSelectorsWallPanelsController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Мощность', '']
				['Реле обхода', '']
				['Количество положений селектора', '']
				['Цвет', '']
				['Вес', '']
				['Габариты', '']
				['Страна производитель', '']
			]
	]