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
      @project.stubs(:builds_from).
        with(branch_name = 'branch_name').
        returns builds = OpenStruct.new(first: build = mock)

      expect(@project.latest_build_from branch_name ).to_equal build
    end
  end

  describe '#builds_resource' do
    it 'returns the build resource from the xml_doc' do
      resource = '/httpAuth/app/rest/buildTypes/id:bt2/builds'
      expect(@project.send :builds_resource, 'master' ).to_equal resource
    end
  end

  describe '#builds_from' do
    it 'calls from_resource on Builds with the builds resource' do
      @project.stubs(:builds_resource).
        with(branch_name = 'branch name').
        returns resource = mock
      Fuci::TeamCity::Builds.stubs(:from_resource).
        with(resource).
        returns builds = mock

      builds_from = @project.send :builds_from, branch_name

      expect(builds_from).to_equal builds
    end
  end

  describe '.from_name' do
    it 'creates a new project object with an xml doc from the response' do
      resource = "/httpAuth/app/rest/projects/name:#{name = 'name'}"
      Fuci::TeamCity::Project.stubs(:project_name).returns name
      Fuci::TeamCity::XmlDocBuilder.stubs(:from_resource).
        with(resource).
        returns xml_doc = mock
      Fuci::TeamCity::Project.stubs(:new).
        with(xml_doc).
        returns project = mock

      from_name = Fuci::TeamCity::Project.from_name
      expect(from_name).to_equal project
    end
  end

  describe '.name' do
    it 'delegates to Fuci::TeamCity.project' do
      Fuci::TeamCity.stubs(:project).returns project = mock
      expect(Fuci::TeamCity::Project.project_name).to_equal project
    end
  end
end
