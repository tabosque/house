require 'fileutils'

module House
  class Base
    include Helpers
    include View
    include Routing

    def initialize()
      @project_root = House.project_root
      @layout = view_dir + '/layouts/application.html.slim'
      House::Routing.initialize
    end

    def call(env)
      @request = Rack::Request.new(env)
      response = Rack::Response.new
      request_path = @request.path
      if House::Routing.exists?(request_path)
        body = render_with_layout(view_file(House::Routing.view(request_path)))
        response.status = 200
        response['Content-Type'] = 'text/html;charset=utf-8'
        response.write body
      else
        response.status = 404
        response['Content-Type'] = 'text/html;charset=utf-8'
        response.write '<h1>404 Not Found</h1>'
      end
      response
    end
  end
end
