require './app/helpers/application_helper.rb'
module House
  module Helpers
    include ApplicationHelper
  end

  class << self
    def project_root
      call_stack = caller_locations.map { |l| l.absolute_path || l.path }
      ru_path = call_stack.find{ |path| path.include?('config.ru')}
      File.absolute_path(ru_path + "/..")
    end
  end
end
