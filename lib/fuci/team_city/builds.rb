require 'fuci/team_city/xml_doc_builder'
require 'fuci/team_city/build'
require 'forwardable'

module Fuci
  module TeamCity
    class Builds < Struct.new :xml_doc
      extend Forwardable

      def_delegator :xml_doc, :xpath

      def each
        xpath('//build').each { |element| yield Build.new(element) }
      end

      def self.from_resource resource
        new xml_doc(resource)
      end

      private

      def self.xml_doc resource
        XmlDocBuilder.from_resource resource
      end
    end
  end
end
