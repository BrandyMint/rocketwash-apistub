ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

Bundler.require :default, ENV['RACK_ENV']

require 'sinatra'
require 'json'
