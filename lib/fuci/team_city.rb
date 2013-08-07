require 'fuci/team_city/version'
require 'fuci/configurable'

module Fuci
  module TeamCity
    include Fuci::Configurable

    class << self
      attr_accessor :host, :username, :password, :default_branch
    end
  end
end
