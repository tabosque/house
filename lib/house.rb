$LOAD_PATH.unshift(File.dirname(File.realpath(__FILE__)) + '/../lib')

require 'rack'
require 'slim'
require 'sprockets'
require 'pry'

require 'house/helpers'
require 'house/view'
require 'house/routing'
require 'house/base'
