require 'forwardable'

module Fuci
  module TeamCity
    class Server < Fuci::Server
      extend Forwardable

      def_delegator :build, :status, :build_status
    end
  end
end
