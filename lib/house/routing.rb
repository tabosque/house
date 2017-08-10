module House
  module Routing
    class << self
      attr_accessor :routes

      def initialize()
        @routes = Array.new
        require './config/routes'
        if ENV['RACK_ENV'] == 'static'
          generate_sitemap          
        end
      end

      def draw(&block)
        instance_eval(&block)
      end

      def root(*args)
        @routes << {path: '/', view: args[0]}
      end

      def get(*args)
        view = args[1].nil? ? args[0] : args[1][:to]
        @routes << {path: args[0], view: view}
      end

      def paths
        @routes.map{|route| route[:path]}
      end

      def exists?(request_path)
        self.paths.include?(request_path)
      end

      def view(path)
        @routes.map{|route| route[:view] if route[:path] == path}.compact.first
      end

      def generate_sitemap
        tmp_dir = 'tmp'
        Dir.mkdir(tmp_dir) unless Dir.exists?(tmp_dir)
        sitemap ="#{tmp_dir}/sitemap.yml"
        File.open(sitemap, 'w') do |f|
          @routes.each {|route| f.puts('- ' + route[:path])}
        end
      end
    end
  end
end