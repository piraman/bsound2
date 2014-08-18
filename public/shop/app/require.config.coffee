'use strict'

require.config
	paths:
		# ngupload: './bower_components/ngUpload/ng-upload'
		# uitree: './../bower_components/angular-ui-tree/dist/angular-ui-tree.min'
		angular: './../bower_components/angular/angular.min'
		domready: './../bower_components/requirejs-domready/domReady'
		lodash: './../bower_components/lodash/dist/lodash.compat'
		# ngtagsinput: './../bower_components/ng-tags-input/ng-tags-input.min'
		restangular: './../bower_components/restangular/dist/restangular'
		# textangular: './../bower_components/textAngular/dist/textAngular.min'
		# textangularsanitize: './../bower_components/textAngular/dist/textAngular-sanitize.min'
		uibootstrap: './../bower_components/angular-bootstrap/ui-bootstrap-tpls.min'
		uirouter: './../bower_components/angular-ui-router/release/angular-ui-router'
	shim:
		# ngupload: ['angular']
		# uitree: ['angular']
		angular: exports: 'angular'
		# ngtagsinput: ['angular']
		restangular: ['angular', 'lodash']
		# textangular: ['angular']
		# textangularsanitize: ['angular']
		uibootstrap: ['angular']
		uirouter: ['angular']
	deps: ['./app.bootstrap']