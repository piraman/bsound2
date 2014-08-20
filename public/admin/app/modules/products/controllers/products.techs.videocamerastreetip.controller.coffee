define ['../products.module'], (product) ->
	'use strict'
	product.controller 'ProductTechsVideoCameraStreetIpController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Компрессия видео', '']
				['Матрица', '']
				['Объектив', '']
				['Фокусное расстояние', '']
				['Минимальная освещенность', '']
				['Чувствительность', '']
				['Разрешение', '']
				['Максимальное число кадров', '']
				['Дальность ИК-подсветки', '']
				['Входы', '']
				['Выходы', '']
				['Сетевой порт', '']
				['Сетевые протоколы', '']
				['Поддержка PoE', '']
				['Рабочая температура', '']
				['Цвет', '']
				['Вес', '']
				['Габариты', '']
				['Страна производитель', '']
				['Питание и потребление', '']
			]
	]