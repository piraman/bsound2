define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsSpeackersController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Диаметр диффузора', '']
				['Диаметр отверстия для установки', '']
				['Мощность', '']
				['Импеданс', '']
				['Звуковое давление', '']
				['Частотный диапазон', '']
				['Класс защиты IP', '']
				['Материал корпуса', '']
				['Цвет', '']
				['Вес', '']
				['Габариты', '']
				['Страна производитель', '']
			]
	]