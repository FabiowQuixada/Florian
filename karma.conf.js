// Karma configuration
// Generated on Sun Feb 26 2017 15:18:55 GMT-0300 (BRT)

module.exports = function(config) {
  config.set({

    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '',


    // frameworks to use
    // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['jasmine-jquery', 'jasmine'],


    // list of files / patterns to load in the browser
    files: [
      'https://code.jquery.com/jquery-1.11.2.min.js',
      'public/javascripts/i18n.js',
      'public/javascripts/translations.js',
      'app/assets/javascripts/**/*.js',
      'app/views/**/*.js',
      'spec/javascripts/**/*.js',
      { pattern: 'spec/javascripts/fixtures/**/*.html', included: false, served: true }
    ],


    // preprocess matching files before serving them to the browser
    // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
      'app/assets/javascripts/**/*.js': ['babel'],
      'app/views/**/*.js': ['babel'],
      'spec/javascripts/**/*js': ['babel']
    },
    babelPreprocessor: {
      options: {
        presets: ['es2015'],
        sourceMap: 'inline'
      },
      filename: function (file) {
        return file.originalPath.replace(/\.js$/, '.es5.js');
      },
      sourceFileName: function (file) {
        return file.originalPath;
      }
    },


    // list of files to exclude
    exclude: [
      'app/assets/javascripts/bootstrap.js',
      'app/assets/javascripts/masks.js',
      'app/assets/javascripts/dates_initializer.js'
    ],


    client: {
      captureConsole: true
    },


    // test results reporter to use
    // possible values: 'dots', 'progress'
    // available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress'],


    // web server port
    port: 9876,


    // enable / disable colors in the output (reporters and logs)
    colors: true,


    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,


    // start these browsers
    // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['PhantomJS'],


    // Continuous Integration mode
    // if true, Karma captures browsers, runs the tests and exits
    singleRun: false,

    // Concurrency level
    // how many browser should be started simultaneous
    concurrency: Infinity,

    plugins : ['karma-jasmine-jquery', 'karma-jasmine', 'karma-phantomjs-launcher', 'karma-babel-preprocessor']
  })
}
