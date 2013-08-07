require 'fuci/server'
require 'forwardable'

module Fuci
  module TeamCity
    class Server < Fuci::Server
      extend Forwardable

      def_delegator :build, :status, :build_status
      def_delegator :build, :log, :fetch_log

      attr_accessor :build

      def initialize
        @build = Fuci::TeamCity::Build.create
      end
    end
  end
end
