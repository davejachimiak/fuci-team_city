require 'fuci/team_city/version'
require 'fuci/team_city/server'

require 'fuci/configurable'

module Fuci
  configure do |fu|
    fu.server = Fuci::TeamCity::Server
  end

  module TeamCity
    include Fuci::Configurable

    class << self
      attr_accessor :host, :username, :password, :default_branch
      attr_reader   :project
    end

    def self.project= project_name
      @project = Project.by_name project_name
    end
  end
end
