define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsActiveMixerPultsController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Мощность', '']
				['Импеданс', '']
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