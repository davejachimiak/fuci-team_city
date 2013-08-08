module Fuci
  module TeamCity
    class Build
      def self.create
        branch = Fuci::TeamCity::CliOptions.branch
        new branch
      end
    end
  end
end
