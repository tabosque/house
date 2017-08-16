#! /bin/sh
exec ruby -S -x "$0" "$@"
#! ruby
require 'fileutils'
require 'pry'

path = ARGV[0]
file_path = "app/views/#{path}.html.slim"
directory = File.dirname(file_path)
FileUtils.mkdir_p(directory) unless FileTest.exist?(directory)
File.open(file_path, "a")
puts "Create #{file_path}"

route_file = "config/routes.rb"
routes = File.open(route_file, "r") { |f| f.read() }
routes.sub!(/House::Routing.draw do/, "House::Routing.draw do\n  get '/#{path}'")
File.open(route_file, "w") { |f| f.write(routes) }
puts "Add /#{path} to route file"