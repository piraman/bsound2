define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsStreetAnalogVideoCameraController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Матрица', '']
				['Объектив', '']
				['Разрешение', '']
				['Минимальная освещенность', '']
				['Режим день/ночь', '']
				['Чувствительность', '']
				['Максимальное число кадров', '']
				['Дальность ИК-подсветки', '']
				['Выходы', '']
				['Рабочая температура', '']
				['Цвет', '']
				['Вес', '']
				['Габариты', '']
				['Страна производитель', '']
				['Питание и потребление', '']
			]
	]