module Fuci
  module TeamCity
    class Build < Struct.new :branch_name
      def self.create
        if branch_name = Fuci::TeamCity::CliOptions.branch
          new branch_name
        else
          create_with_default_branch
        end
      end

      private

      def self.create_with_default_branch
        if branch_name = Fuci::TeamCity.default_branch
          new branch_name
        else
          puts 'No default branch is configured.'
          exit
        end
      end
    end
  end
end
