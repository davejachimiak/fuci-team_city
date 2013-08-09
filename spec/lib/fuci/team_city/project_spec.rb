require_relative '../../../spec_helper'
require_relative '../../../../lib/fuci/team_city/project'

describe Fuci::TeamCity::Project do
  before do
    xml      = File.read('spec/sample_data/project.xml')
    @xml_doc = Nokogiri::XML xml
    @project = Fuci::TeamCity::Project.new @xml_doc
  end

  describe '#initialize' do
    it 'instantiates the xml_doc' do
      expect(@project.xml_doc).to_equal @xml_doc
    end
  end

  describe '#latest_build_from' do
    it 'returns a wrapped build from the branch name' do
      @project.stubs(:build_resource).
        with(branch_name = 'branch name').
        returns build_resource = mock
      Fuci::TeamCity::Build.stubs(:from_resource).
        with(build_resource).
        returns raw_build = mock

      expect(@project.latest_build_from branch_name ).to_equal raw_build
    end
  end

  describe '#build_resource' do
    it 'returns the build resource from the xml_doc' do
      resource = '/httpAuth/app/rest/buildTypes/id:bt2'
      expect(@project.send :build_resource, 'master' ).to_equal resource
    end
  end

  describe '.from_name' do
    it 'creates a new project object with an xml doc from the response' do
      resource = "/httpAuth/app/rest/projects/name:#{name = 'name'}"
      Fuci::TeamCity::XmlDocBuilder.stubs(:from_resource).
        with(resource).
        returns xml_doc = mock
      Fuci::TeamCity::Project.stubs(:new).
        with(xml_doc).
        returns project = mock

      from_name = Fuci::TeamCity::Project.from_name name
      expect(from_name).to_equal project
    end
  end
end
