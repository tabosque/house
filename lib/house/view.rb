module House
  module View
    def render_with_layout(template)
      Slim::Template.new(@layout).render(self){Slim::Template.new(template).render(self)}
    end

    def render(template)
      path_array = template.split('/')
      view_file = path_array.last.insert(0, '_')
      path_array.pop
      path_array.push(view_file)
      Slim::Template.new(view_file(path_array.join('/'))).render(self)
    end

    def view_file(path)
      view_dir + path + '.html.slim'
    end

    def view_dir
      @project_root + "/app/views/"
    end
  end
end
