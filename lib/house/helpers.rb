require './app/helpers/application_helper.rb'
require 'pathname'
module House
  module Helpers
    include ApplicationHelper
  end

  class << self
    def project_root
      call_stack = caller_locations.map { |l| l.absolute_path || l.path }
      path1 = call_stack.find{ |path| path.include?('config.ru')} || call_stack.select{ |path| path.include?('vendor')}[1]
      path2 = call_stack.select{ |path| path.include?('vendor')}[2]
      Pathname.new(self.longest_common_string(path1, path2))
    end

    def longest_common_string(path1, path2)
      compare_array = path1.split(//).zip(path2.split(//)).map{ |e| e.uniq.length == 1 }
      idx = compare_array.index(false)
      if idx.nil?
        ""
      else
        path1[0...idx]
      end
    end
  end
end
