require 'fuci/team_city/xml_doc_builder'

module Fuci
  module TeamCity
    class Builds < Struct.new :xml_doc
      def self.from_resource resource
        new xml_doc(resource)
      end

      private

      def self.xml_doc resource
        XmlDocBuilder.from_resource(resource)
      end
    end
  end
end

require_relative '../../../spec/spec_helper'

describe Fuci::TeamCity::Builds do
  describe '.from_resource' do
    it 'returns a new Builds object an xml doc' do
      Fuci::TeamCity::XmlDocBuilder.stubs(:from_resource).
        with(resource = '/resource').
        returns xml_doc = mock
      Fuci::TeamCity::Builds.stubs(:new).
        with(xml_doc).
        returns builds = mock

      from_resource = Fuci::TeamCity::Builds.from_resource resource

      expect(from_resource).to_equal builds
    end
  end
end
