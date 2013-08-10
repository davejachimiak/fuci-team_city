require 'fuci/cli_options'

module Fuci
  module TeamCity
    class CliOptions
      def self.branch
        argv.first
      end

      private

      def self.argv
        Fuci::CliOptions.argv
      end
    end
  end
end
