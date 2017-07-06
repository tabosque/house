require File.dirname(__FILE__) + '/lib/house'
use Rack::Reloader, 2

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'app/assets/javascripts'
  environment.append_path 'app/assets/stylesheets'
  environment.append_path 'vendor/assets'
  environment.append_path 'vendor/bundle'
  unless ENV['RACK_ENV'] == 'development'
    environment.js_compressor  = :uglify
    environment.css_compressor = :scss
  end
  run environment
end

map '/' do
  run House::Base.new
end
