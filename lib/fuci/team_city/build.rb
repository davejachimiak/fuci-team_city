require 'fuci/team_city/xml_doc_builder'
require 'fuci/team_city/request'
require 'forwardable'

module Fuci
  module TeamCity
    class Build < Struct.new :xml_doc
      extend Forwardable

      LOG_RESOURCE = lambda { |id| "/downloadBuildLog.html?buildId=#{id}" }

      def_delegator :xml_doc, :xpath

      def status_code
        case status
        when 'ERROR'
          :red
        when 'SUCCESS'
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

      def self.from_resource resource
        new xml_doc(resource)
      end

      private

      def status
        xpath('/build/@status').first.value
      end

      def log_resource
        LOG_RESOURCE.(id)
      end

      def id
        xpath('/build/@id').first.value
      end

      def self.project
        Fuci::TeamCity.project
      end

      def self.create_with_default_branch
        if branch_name = Fuci::TeamCity.default_branch
          project.latest_build_from branch_name
        else
          puts 'No default branch is configured.'
          exit
        end
      end

      def self.xml_doc resource
        XmlDocBuilder.from_resource resource
      end
    end
  end
end
