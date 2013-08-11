require 'fuci/team_city/request'
require 'fuci/team_city/project'
require 'fuci/team_city/cli_options'
require 'fuci/team_city/xml_doc_builder'

module Fuci
  module TeamCity
    class Build < Struct.new :element
      ERROR        = 'ERROR'
      SUCCESS      = 'SUCCESS'
      LOG_RESOURCE = lambda { |id| "/downloadBuildLog.html?buildId=#{id}" }

      def status_code
        case status
        when ERROR
          :red
        when SUCCESS
          :green
        else
          :yellow
        end
      end

      def log
        Request.new(log_resource).call
      end

      def self.create
        if branch_name = Fuci::TeamCity::CliOptions.branch
          project.latest_build_from branch_name
        else
          create_with_default_branch
        end
      end

      private

      def status
        element['status']
      end

      def log_resource
        LOG_RESOURCE.(id)
      end

      def id
        element['id']
      end

      def self.project
        Fuci::TeamCity::Project.from_name
      end

      def self.create_with_default_branch
        if branch_name = Fuci::TeamCity.default_branch
          project.latest_build_from branch_name
        else
          puts 'No default branch is configured.'
          exit
        end
      end
    end
  end
end
