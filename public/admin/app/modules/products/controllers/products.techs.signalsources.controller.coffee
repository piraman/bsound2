define ['../products.module'], (product) ->

	product.controller 'ProductTechsSignalSourcesController', [
		'$scope'
		($scope) ->
			unless $scope.product.techs then $scope.product.techs = [
				['Артикул', '']
				['Тип', '']
				['Воспроизводимые форматы', '']
				['Входы', '']
				['Выходы', '']
				['Частотный диапозон', '']
				['Сеть', '']
				['Рэковое крепление', '']
				['Цвет', '']
				['Вес', '']
				['Габариты', '']
				['Страна производитель', '']
				['Питание и потребление', '']
			]
	]