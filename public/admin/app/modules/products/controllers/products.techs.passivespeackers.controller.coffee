define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsPassiveSpeackersController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
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
			]
	]