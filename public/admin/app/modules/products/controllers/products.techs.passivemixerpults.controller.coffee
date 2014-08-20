define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsPassiveMixerPultsController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Количество каналов', '']
				['Входы', '']
				['Выходы', '']
				['Эквалайзер', '']
				['Процессор', '']
				['Рэковое крепление', '']
				['Цвет', '']
				['Вес', '']
				['Габариты', '']
				['Страна производитель', '']
				['Питание и потребление', '']
			]
	]