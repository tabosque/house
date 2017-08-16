#! /bin/sh
exec ruby -S -x "$0" "$@"
#! ruby
$LOAD_PATH << File.dirname(File.expand_path(__FILE__))
require 'static/utils'
require 'yaml'
require 'uri'
require 'pry'

# Remove old public_html directory and zip file
if File.exists?('public_html')
  system("rm -rf public_html")
end
if File.exists?('public_html.zip')
  system("rm public_html.zip")
end

# Start Rack application
system("bundle exec rackup -p 3100 -P tmp/rack.pid.static -E static -D")

# Set sitemap
yaml = YAML::load_file(File.expand_path("../..", __FILE__) + '/../tmp/sitemap.yml')

# Download files
localhost = "localhost:3100"
root_url = URI("http://#{localhost}")
puts "Downloading files...\n----"
sleep(2)
yaml.each do |path|
  url = root_url + path
  puts "Download: #{url}"
  download(url, root_url)
end

# Stop Rack application
system("kill -9 `cat tmp/rack.pid.static`")

# Rename file directory to public_html
system("mv #{localhost} public_html")

# Zip files
system("zip -9r public_html.zip public_html")

puts "----\nDownload finished"