module Fuci
  module TeamCity
    class Build
      def self.create
        branch =
          Fuci::TeamCity::CliOptions.branch ||
          Fuci::TeamCity.default_branch

        new branch
      end
    end
  end
end
