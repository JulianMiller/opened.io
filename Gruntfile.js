/**
 *
 *     OpenEd web application grunt config
 *
 */

'use strict';

var LIVERELOAD_PORT = 35729;

// get live reload snippet instance
var lrSnippet = require('connect-livereload')({port: LIVERELOAD_PORT});

// mount folder function
var mountFolder = function (connect, dir) {
	return connect.static(require('path').resolve(dir));
};


// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/{,*/}*.js'
// use this if you want to match all subfolders:
// 'test/spec/**/*.js'

module.exports = function (grunt) {

	// load all grunt tasks
	require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);
	grunt.loadNpmTasks('grunt-shell');

	// configurable paths
	var yeomanConfig = {
		app: 'app',
		dist: 'heroku/dist',
		tmp: '.tmp'
	};

	grunt.initConfig({
		yeoman: yeomanConfig,
		shell: {
			options: {
				stdout: true
			},
			karmaStart: {
				command: 'karma start'
			}
		},
		watch: {
			emberTemplates: {
				files: '<%= yeoman.app %>/templates/**/*.hbs',
				tasks: ['emberTemplates']
			},
			coffee: {
				files: ['<%= yeoman.app %>/scripts/**/*.coffee'],
				tasks: ['coffee:dist']
			},
			compass: {
				files: ['<%= yeoman.app %>/styles/{,*/}*.{scss,sass}'],
				tasks: ['compass:server']
			},
			neuter: {
				files: ['<%= yeoman.tmp %>/scripts/app.js'],
				tasks: ['customNeuter']
			},
			livereload: {
				options: {
					livereload: LIVERELOAD_PORT
				},
				files: [
					'<%= yeoman.app %>/*.html',
					'<%= yeoman.tmp %>/styles/{,*/}*.css',
					'{<%= yeoman.tmp %>,<%= yeoman.app %>}/scripts/{,*/}*.js',
					'<%= yeoman.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
				]
			}
		},
		// connect web-server, use this in the development, we are using express in staging/production
		connect: {
			options: {
				port: 9000,
				hostname: '0.0.0.0'
			},
			dev: {
				options: {
					middleware: function (connect) {
						return [
							lrSnippet,
							mountFolder(connect, yeomanConfig.tmp),
							mountFolder(connect, yeomanConfig.app)
						];
					}
				}
			},
			dist: {
				options: {
					middleware: function (connect) {
						return [
							mountFolder(connect, yeomanConfig.dist)
						];
					}
				}
			}
		},
		open: {
			server: {
				path: 'http://localhost:<%= connect.options.port %>'
			}
		},
		clean: {
			dist: {
				files: [
					{
						dot: true,
						src: [
							'.tmp',
							'<%= yeoman.dist %>/*',
							'heroku/.git'
						]
					}
				]
			},
			server: '.tmp'
		},
		jshint: {
			options: {
				jshintrc: '.jshintrc'
			},
			all: [
				'Gruntfile.js',
				'<%= yeoman.app %>/scripts/{,*/}*.js',
				'!<%= yeoman.app %>/scripts/vendor/*',
				'test/spec/{,*/}*.js'
			]
		},
		coffee: {
			dist: {
				files: [
					{
						expand: true,
						cwd: '<%= yeoman.app %>/scripts',
						src: '**/*.coffee',
						dest: '.tmp/scripts',
						ext: '.js'
					},
					{
						expand: true,
						cwd: 'app/custom_components/helpers',
						src: '**/*.coffee',
						dest: '.tmp/scripts',
						ext: '.js'
					}
				]
			}
		},
		compass: {
			forcecomplite: true,
			options: {
				sassDir: '<%= yeoman.app %>/styles',
				cssDir: '.tmp/styles',
				generatedImagesDir: '.tmp/images/generated',
				imagesDir: '<%= yeoman.app %>/images',
				javascriptsDir: '<%= yeoman.app %>/scripts',
				fontsDir: '<%= yeoman.app %>/styles/fonts',
				importPath: 'app/bower_components',
				httpImagesPath: '/images',
				httpGeneratedImagesPath: '/images/generated',
				httpFontsPath: '/fonts',
				relativeAssets: false
			},
			dist: {},
			server: {
				options: {
					//debugInfo: true
				}
			}
		},
		rev: {
			dist: {
				files: {
					src: [
						'<%= yeoman.dist %>/scripts/{,*/}*.js',
						'<%= yeoman.dist %>/styles/{,*/}*.css',
						//'<%= yeoman.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp}',
						'<%= yeoman.dist %>/fonts/*'
					]
				}
			}
		},
		useminPrepare: {
			html: '<%= yeoman.app %>/index.html',
			options: {
				dest: '<%= yeoman.dist %>'
			}
		},
		usemin: {
			html: ['<%= yeoman.dist %>/{,*/}*.html'],
			css: ['<%= yeoman.dist %>/styles/{,*/}*.css'],
			options: {
				dirs: ['<%= yeoman.dist %>']
			}
		},
		imagemin: {
			dist: {
				files: [
					{
						expand: true,
						cwd: '<%= yeoman.app %>/images',
						src: '{,*/}*.{png,jpg,jpeg}',
						dest: '<%= yeoman.dist %>/images'
					}
				]
			}
		},
		svgmin: {
			dist: {
				files: [
					{
						expand: true,
						cwd: '<%= yeoman.app %>/images',
						src: '{,*/}*.svg',
						dest: '<%= yeoman.dist %>/images'
					}
				]
			}
		},
		cssmin: {
			dist: {
				files: {
					'<%= yeoman.dist %>/styles/main.css': [
						'.tmp/styles/{,*/}*.css',
						'<%= yeoman.app %>/styles/{,*/}*.css'
					]
				}
			}
		},
		htmlmin: {
			dist: {
				options: {
					/*removeCommentsFromCDATA: true,
					 // https://github.com/yeoman/grunt-usemin/issues/44
					 //collapseWhitespace: true,
					 collapseBooleanAttributes: true,
					 removeAttributeQuotes: true,
					 removeRedundantAttributes: true,
					 useShortDoctype: true,
					 removeEmptyAttributes: true,
					 removeOptionalTags: true*/
				},
				files: [
					{
						expand: true,
						cwd: '<%= yeoman.app %>',
						src: '*.html',
						dest: '<%= yeoman.dist %>'
					}
				]
			}
		},
		// Put files not handled in other tasks here
		copy: {
			dist: {
				files: [
					{
						expand: true,
						dot: true,
						cwd: '<%= yeoman.app %>',
						dest: '<%= yeoman.dist %>',
						src: [
							'*.{ico,txt}',
							'.htaccess',
							'images/{,*/}*.{webp,gif,ico}',
							'font/*'
						]
					}
				]
			}
		},
		concurrent: {
			server: [
				'emberTemplates',
				'coffee:dist',
				'compass:server'
			],
			test: [
				'coffee',
				'compass'
			],
			dist: [
				'emberTemplates',
				'coffee',
				'compass:dist',
				'imagemin',
				'svgmin',
				'htmlmin'
			]
		},
		emberTemplates: {
			options: {
				templateName: function (sourceFile) {
					var templatePath = yeomanConfig.app + '/templates/';
					return sourceFile.replace(templatePath, '');
				}
			},
			dist: {
				files: {
					'.tmp/scripts/compiled-templates.js': '<%= yeoman.app %>/templates/**/*.hbs'
				}
			}
		},
		neuter: {
			options: {
				//includeSourceURL: true
				template: "{%= src %}",
				filepathTransform: function (filepath) {
					return '.tmp/' + filepath;
				}
			}
		}
	});

	var getGithubHost = function (env) {
		var jsonConfig = grunt.file.readJSON('configs/' + env + '.json');
		return jsonConfig.HEROKU_GIT
	};

	grunt.registerTask('writeConfigs', function (env) {
		var jsonConfig = grunt.file.read('configs/' + env + '.json');
		console.log(jsonConfig);
		var content = '(function() { window.CONFIG = ' + jsonConfig + '}).call(this);';

		grunt.file.write('.tmp/scripts/configs/' + env + '.js', content)
	});

	grunt.registerTask('commitToLocalGit', function () {
		var msg = grunt.option('msg') || "I'm a silly and forgot to put a description";
		var commitMsg = 'git commit -am "' + msg + '"';

		var val =  {
			command: [
				'cd heroku',
				'git init',
				'git add .',
				commitMsg
			].join('&&')
		};

		grunt.config.set('shell.commitToLocalGit', val);
		grunt.task.run('shell:commitToLocalGit')
	});

	grunt.registerTask('pushToHeroku', function (env) {
		var currGithubHost = getGithubHost(env);

		var val = {
			command: [
				'cd heroku',
				'git remote add heroku ' + currGithubHost,
				'git push heroku master --force'
			].join('&&')
		};

		grunt.config.set('shell.pushToHeroku', val);
		grunt.task.run('shell:pushToHeroku')
	});

	grunt.registerTask('customNeuter', function (env) {
		var envFixed = env || 'dev';
		var configsPath = '.tmp/scripts/configs/';

		var val = {
			files: {
				".tmp/scripts/combined-scripts.js": [ configsPath + envFixed + '.js', ".tmp/scripts/app.js"]
			}
		};

		grunt.config.set('neuter.app', val);
		grunt.task.run('neuter:app')
	});

	grunt.registerTask('deploy', function () {
		var env = grunt.option('env') || 'staging';

		return grunt.task.run([
			'build:' + env,
			'commitToLocalGit',
			'pushToHeroku:' + env
		])
	});

	grunt.registerTask('server', function () {
		var env = grunt.option('env') || 'dev';

		return grunt.task.run([
			'clean:server',
			'concurrent:server',
			'writeConfigs:' + env,
			'customNeuter:' + env,
			'connect:dev',
			'watch'
		])
	});

	grunt.registerTask('build', function (env) {

		var uglify =  grunt.option('noUgly') ? 'empty' : 'uglify';

		var envFixed = env || grunt.option('env');

		grunt.task.run([
			'clean:dist',
			'useminPrepare',
			'concurrent:dist',
			'writeConfigs:' + envFixed,
			'customNeuter:' + envFixed,
			'concat',
			//'cssmin',
			uglify,
			'copy',
			'rev',
			'usemin'
		])
	});

	grunt.registerTask('empty', function () {});

};