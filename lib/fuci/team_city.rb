require 'fuci'
require 'forwardable'
require 'fuci/configurable'
require 'fuci/team_city/server'
require 'fuci/team_city/project'
require 'fuci/team_city/version'

module Fuci
  configure do |fu|
    fu.server = Fuci::TeamCity::Server
  end

  module TeamCity
    include Fuci::Configurable

    class << self
      extend Forwardable
      def_delegator :Fuci, :add_testers
      attr_accessor :host, :project, :default_branch, :username, :password
    end
  end
end
