module House
  module Helpers
  end

  class << self
    def project_root
      call_stack = caller_locations.map { |l| l.absolute_path || l.path }
      ru_path = call_stack.find{ |path| path.include?('config.ru')}
      File.absolute_path(ru_path + "/..")
    end
  end
end
