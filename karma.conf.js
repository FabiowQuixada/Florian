// Karma configuration
// Generated on Sun Feb 26 2017 15:18:55 GMT-0300 (BRT)
const path = require('path');
const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const webpackConfig = require('./webpack.config.js');
webpackConfig.entry = null;

module.exports = function(config) {
  config.set({
    basePath: '',
    frameworks: ['jasmine-jquery', 'jasmine'],
    reporters: ['progress'],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO, // LOG_DEBUG
    autoWatch: true,
    browsers: ['PhantomJS'],
    singleRun: false,
    concurrency: Infinity,
    webpack: webpackConfig,
    webpackMiddleware: { noInfo: true  },
    client: { captureConsole: true },

    files: [
      'https://code.jquery.com/jquery-1.11.2.min.js',
      'spec/javascripts/**/*.js',
      'spec/javascripts/**/*.jsx',
      { pattern: 'app/frontend/javascripts/**/*.js', included: false },
      { pattern: 'app/frontend/javascripts/**/*.jsx', included: false },
      { pattern: 'spec/javascripts/fixtures/**/*.html', included: false, served: true }
    ],

    exclude: [
      'app/frontend/javascripts/bootstrap.js',
      'app/frontend/javascripts/masks.js',
      'app/frontend/javascripts/dates_initializer.js',
    ],

    preprocessors: {
      './app/assets/javascripts/bundle.js': ['webpack'],
      'app/frontend/javascripts/**/*.js': ['babel'],
      'app/frontend/javascripts/**/*.jsx': ['babel'],
      'spec/javascripts/**/*.js': ['webpack', 'babel'],
      'spec/javascripts/**/*.jsx': ['webpack', 'babel'],
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

    plugins: [
      'karma-jasmine-jquery',
      'karma-jasmine',
      'karma-phantomjs-launcher',
      'karma-babel-preprocessor',
      'karma-webpack',
    ]
  })
}
