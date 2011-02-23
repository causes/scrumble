$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))

require 'rubygems'
require 'sinatra'
require 'init'

run ScrumApp
