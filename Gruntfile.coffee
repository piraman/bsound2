module.exports = (grunt) ->
	grunt.initConfig
		jade:
			options:
				pretty: yes
			compile:
				expand: yes
				cwd: './'
				src: [
					'public/**/*.jade'
					'views/**/*.jade'
				]
				dest: './'
				ext: '.html'
				extDot: 'last'
		stylus:
			options:
				compress: no
			compile:
				expand: yes
				cwd: './'
				src: [
					'public/**/*.styl'
				]
				dest: './'
				ext: '.css'
				extDot: 'last'
		coffee:
			options:
				bare: no
			compile:
				expand: yes
				cwd: './'
				src: [
					'**/*.coffee'
					'!node_modules/**'
					'!Gruntfile.coffee'
				]
				dest: './'
				ext: '.js'
				extDot: 'last'
		watch:
			options:
				livereload:
					port: 10101
			jade:
				files: [
					'public/**/*.jade'
					'views/**/*.jade'
				]
				tasks: ['newer:jade']
			stylus:
				files: [
					'public/**/*.styl'
				]
				tasks: ['newer:stylus']
			coffee:
				files: [
					'**/*.coffee'
					'!node_modules/**'
					'!Gruntfile.coffee'
				]
				tasks: ['newer:coffee']

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-jade'
	grunt.loadNpmTasks 'grunt-contrib-stylus'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-newer'

	grunt.registerTask 'default', ['jade', 'stylus', 'coffee', 'watch']