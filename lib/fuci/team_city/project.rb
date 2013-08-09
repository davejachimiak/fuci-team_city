require 'fuci/team_city/xml_doc_builder'
require 'fuci/team_city/build'
require 'forwardable'

module Fuci
  module TeamCity
    class Project < Struct.new :xml_doc
      extend Forwardable

      RESOURCE = lambda { |name| "/httpAuth/app/rest/projects/name:#{name}" }

      def_delegator :xml_doc, :xpath

      def latest_build_from branch_name
        build_from build_resource(branch_name)
      end

      def self.from_name name
        new xml_doc(name)
      end

      private

      def build_resource branch_name
        xpath("//buildType[@name=\"#{branch_name}\"]").attr('href').value
      end

      def build_from resource
        Build.from_resource resource
      end

      def self.xml_doc name
        XmlDocBuilder.from_resource RESOURCE.(name)
      end
    end
  end
end
