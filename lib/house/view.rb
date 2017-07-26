module House
  module View
    def render_with_layout(template)
      render_slim_file(@layout){render_slim_file(template)}
    end

    def render(template)
      path_array = template.split('/')
      view_file = path_array.last.insert(0, '_')
      path_array[-1] = view_file
      render_slim_file(view_file(path_array.join('/')))
    end

    def view_file(path)
      view_dir + path + '.html.slim'
    end

    def view_dir
      @project_root + "/app/views/"
    end

    private
      def render_slim_file(file, &block)
        Slim::Template.new(file).render(self, &block)
      end
  end
end
