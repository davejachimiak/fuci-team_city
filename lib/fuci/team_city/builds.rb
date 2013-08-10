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
        XmlDocBuilder.from_resource(resource)
      end
    end
  end
end

require_relative '../../../spec/spec_helper'
require 'nokogiri'

describe Fuci::TeamCity::Builds do
  before do
    xml      = File.read 'spec/sample_data/builds.xml'
    @xml_doc = Nokogiri::XML xml
    @builds  = Fuci::TeamCity::Builds.new @xml_doc
  end

  describe 'composition' do
    it 'inherits from Enumerable' do
      expect(@builds).to_be_kind_of Enumerable
    end
  end

  describe '#initialize' do
    it 'sets the xml_doc' do
      expect(@builds.xml_doc).to_equal @xml_doc
    end
  end

  describe '#each' do
    it 'instantiates each build node with Build' do
      (xml_doc = mock).stubs(:xpath).
        with('//build').
        returns [element = mock]
      @builds.stubs(:xml_doc).returns xml_doc
      Fuci::TeamCity::Build.stubs(:new).
        with(element).
        returns build = mock

      expects(:puts).with build

      @builds.each { |build| puts build }
    end
  end

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
