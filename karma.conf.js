// Karma configuration
var path = require('path');

module.exports = function (karma) {

    path.sep = "/";

    karma.set({

        // base path, that will be used to resolve files and exclude
        basePath: '',

        // frameworks to use
        frameworks: ['qunit', 'jasmine'],

        // list of files / patterns to load in the browser
        files: [

            // plugins
			{ pattern: 'app/bower_components/jquery/jquery.js', watched: false, served: true, included: true},
			{ pattern: 'app/bower_components/handlebars/handlebars.runtime.js', watched: false, served: true, included: true},
			{ pattern: 'app/bower_components/ember/ember.js', watched: false, served: true, included: true},
			{ pattern: 'app/bower_components/ember-model/ember-model.js', watched: false, served: true, included: true},
            { pattern: 'app/custom_components/ember-data.js', watched: false, served: true, included: true},
			{ pattern: 'app/custom_components/helpers/handlebars_helpers.coffee', watched: false, served: true, included: true},
      		{ pattern: 'app/bower_components/fancybox/source/jquery.fancybox.js', watched: false, served: true, included: true},

			// deps for testing
			{ pattern: 'app/bower_components/jquery-mockjax/jquery.mockjax.js', watched: false, served: true, included: true},
			{ pattern: 'app/bower_components/jasmine-jquery/lib/jasmine-jquery.js', watched: false, served: true, included: true},

			// testing utils before we loading our application
			{ pattern: 'test/lib/before_app.coffee', watched: false, served: true, included: true},

			// application components
			{ pattern: 'app/templates/**/*.hbs', watched: true, served: true, included: true},
      
            'app/scripts/app_setup.coffee',
            'app/scripts/router.coffee',
            'app/scripts/store.coffee',
            'app/scripts/helpers/**/*.coffee',
            'app/scripts/routes/**/*.coffee',
            'app/scripts/models/**/*.coffee',
            'app/scripts/views/**/*.coffee',
            'app/scripts/controllers/**/*.coffee',
            'app/scripts/lib/**/*.coffee',
            'app/scripts/components/**/*.coffee',

			// testing ulits
			{ pattern: 'test/lib/testing_setup.coffee', watched: false, served: true, included: true},

			// fixtures, loaded by jasmine fixture method getFixtures, see course_test.coffee for reference
			{ pattern: 'test/fixtures/**/*.js', watched: false, served: true, included: true},

            // test helpers
            'test/spec/helpers/**/*.coffee',

			// tests
            'test/spec/unit/**/*.coffee',
            'test/spec/integration/**/*.coffee'

        ],


        // list of files to exclude
        exclude: [
          //'test/spec/integration/profile/**',
          //'test/spec/integration/help/**',
          //'test/spec/integration/search/**',
          //'test/spec/integration/playlist/**',
          //'test/spec/integration/lms/courses_test.coffee',
          //'test/spec/integration/lms/topics_test.coffee',
          //'test/spec/unit/**/*.coffee'
        ],

        // test results reporter to use
        // possible values: 'dots', 'progress', 'junit', 'growl', 'coverage'
        reporters: ['spec'],

        // web server port
        port: 9876,

        // cli runner port
        runnerPort: 9100,

        // enable / disable colors in the output (reporters and logs)
        colors: true,

        // level of logging
        // possible values: karma.LOG_DISABLE || karma.LOG_ERROR || karma.LOG_WARN || karma.LOG_INFO || karma.LOG_DEBUG
        logLevel: karma.LOG_ERROR,

        // enable / disable watching file and executing tests whenever any file changes
        autoWatch: true,

        // Start these browsers, currently available:
        // - Chrome
        // - ChromeCanary
        // - Firefox
        // - Opera
        // - Safari (only Mac)
        // - PhantomJS
        // - IE (only Windows)
        browsers: ['Firefox'],
        //browsers: ['PhantomJS'],

        // If browser does not capture in given timeout [ms], kill it
        captureTimeout: 60000,

        // Continuous Integration mode
        // if true, it capture browsers, run tests and exit
        singleRun: false,

		plugins: [
			'karma-qunit',
			'karma-jasmine',
            'karma-spec-reporter',
			'karma-chrome-launcher',
			'karma-firefox-launcher',
			'karma-ember-preprocessor',
			'karma-coffee-preprocessor',
			'karma-phantomjs-launcher'
		],

		preprocessors: {
			"**/*.hbs": 'ember',
			"**/*.coffee": 'coffee'
		}
    });
};
