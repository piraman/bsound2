define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsMicrophonesController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Направленность', '']
				['Чувствительность', '']
				['Частотный диапазон', '']
				['Выход', '']
				['Цвет', '']
				['Вес', '']
				['Габариты', '']
				['Страна производитель', '']
			]
	]