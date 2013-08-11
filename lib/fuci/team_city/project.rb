require 'fuci/team_city/xml_doc_builder'
require 'fuci/team_city/builds'
require 'forwardable'

module Fuci
  module TeamCity
    class Project < Struct.new :xml_doc
      extend Forwardable

      RESOURCE = lambda { |name| "/httpAuth/app/rest/projects/name:#{name}" }

      def_delegator :xml_doc, :xpath

      def latest_build_from branch_name
        builds_from(branch_name).first
      end

      def self.from_name
        new xml_doc
      end

      private

      def builds_from branch_name
        Builds.from_resource builds_resource(branch_name)
      end

      def builds_resource branch_name
        xpath("//buildType[@name=\"#{branch_name}\"]").
          attr('href').
          value +
          '/builds'
      end

      def self.xml_doc
        XmlDocBuilder.from_resource RESOURCE.(project_name)
      end

      def self.project_name
        Fuci::TeamCity.project
      end
    end
  end
end
