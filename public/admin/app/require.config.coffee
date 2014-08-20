'use strict'
String::bool = ->
	/^true$/i.test @
window.guid = ->
	do "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxxx".replace(/[xy]/g, (c) ->
		r = Math.random() * 16 | 0
		v = (if c is "x" then r else (r & 0x3 | 0x8))
		v.toString 16
	).toUpperCase

require.config
	paths:
		# ngupload: './bower_components/ngUpload/ng-upload'
		uitree: './../bower_components/angular-ui-tree/dist/angular-ui-tree.min'
		angular: './../bower_components/angular/angular.min'
		domready: './../bower_components/requirejs-domready/domReady'
		lodash: './../bower_components/lodash/dist/lodash.compat.min'
		ngtagsinput: './../bower_components/ng-tags-input/ng-tags-input.min'
		restangular: './../bower_components/restangular/dist/restangular.min'
		textangular: './../bower_components/textAngular/dist/textAngular.min'
		textangularsanitize: './../bower_components/textAngular/dist/textAngular-sanitize.min'
		uibootstraptemplates: './../bower_components/angular-bootstrap/ui-bootstrap-tpls.min'
		uirouter: './../bower_components/angular-ui-router/release/angular-ui-router.min'
		contextmenu: './../bower_components/ng-context-menu/dist/ng-context-menu.min'
	shim:
		# ngupload: ['angular']
		uitree: ['angular']
		angular: exports: 'angular'
		ngtagsinput: ['angular']
		restangular: ['angular', 'lodash']
		textangular: ['angular']
		textangularsanitize: ['angular']
		uibootstraptemplates: ['angular']
		uirouter: ['angular']
		contextmenu: ['angular']
	deps: ['./app.bootstrap']
