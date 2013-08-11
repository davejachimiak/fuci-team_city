require_relative '../../../spec_helper'
require_relative '../../../../lib/fuci/team_city/build'

stub_class 'Fuci::TeamCity::CliOptions'

describe Fuci::TeamCity::Build do
  before do
    xml      = File.read 'spec/sample_data/builds.xml'
    xml_doc  = Nokogiri::XML xml
    @element = xml_doc.xpath('//build').first
    @build   = Fuci::TeamCity::Build.new @element
  end

  describe '#initialize' do
    it 'sets the xml_doc passed in' do
      expect(@build.element).to_equal @element
    end
  end

  describe '#status_code' do
    before { @status = @build.stubs :status  }

    describe 'when status is ERROR' do
      before { @status.returns 'ERROR' }

      it 'returns :red' do
        expect(@build.status_code).to_equal :red
      end
    end

    describe 'when status is passed' do
      before { @status.returns 'SUCCESS' }

      it 'returns :green' do
        expect(@build.status_code).to_equal :green
      end
    end

    describe 'when status is something else' do
      it 'returns :yellow' do
        expect(@build.status_code).to_equal :yellow
      end
    end
  end

  describe '#log' do
    it 'makes a request with the log resource' do
      @build.stubs(:id).returns id = 12345
      resource = "/downloadBuildLog.html?buildId=#{id}"
      Fuci::TeamCity::Request.stubs(:new).
        with(resource).returns request = mock
      request.stubs(:call).returns log = mock

      expect(@build.log).to_equal log
    end
  end

  describe '#status' do
    it 'returns the status from the xml doc' do
      expect(@build.send :status ).to_equal 'ERROR'
    end
  end

  describe '#id' do
    it 'returns the id from the xml doc' do
      expect(@build.send :id ).to_equal '8134'
    end
  end

  describe '.project' do
    it 'Calls Project.from_name' do
      Fuci::TeamCity::Project.stubs(:from_name).returns project = mock
      expect(Fuci::TeamCity::Build.send :project ).to_equal project
    end
  end

  describe '.from_resource' do
    it 'returns a new raw build from the resource' do
      Fuci::TeamCity::XmlDocBuilder.stubs(:from_resource).
        with(resource = 'resource').
        returns xml_doc = mock
      Fuci::TeamCity::Build.stubs(:new).
        with(xml_doc).
        returns build = mock

      from_resource = Fuci::TeamCity::Build.from_resource resource
      expect(from_resource).to_equal build
    end
  end

  describe '.create' do
    before do
      @branch = Fuci::TeamCity::CliOptions.stubs :branch
    end

    describe 'when a branch is passed in the cli' do
      before do
        @branch_name = 'branch'
        @branch.returns @branch_name
      end

      it 'creates a new build with the branch passed in' do
        Fuci::TeamCity::Build.stubs(:project).
          returns project = mock
        project.stubs(:latest_build_from).
          with(@branch_name).returns build = mock
        expect(Fuci::TeamCity::Build.create).to_equal build
      end
    end

    describe 'when a branch is not passed in the cli' do
      before do
        @default_branch = Fuci::TeamCity.stubs :default_branch
      end

      describe 'when a default branch is configured' do
        before do
          @branch_name = 'branch'
          @default_branch.returns @branch_name
        end

        it 'creates a new build with the default branch' do
          Fuci::TeamCity::Build.stubs(:project).
            returns project = mock
          project.stubs(:latest_build_from).
            with(@branch_name).returns build = mock
          expect(Fuci::TeamCity::Build.create).to_equal build
        end
      end

      describe 'when a default branch is not configured' do
        it 'logs that no default branch is configured' do
          Fuci::TeamCity::Build.expects(:puts).
            with 'No default branch is configured.'
          Fuci::TeamCity::Build.expects :exit

          Fuci::TeamCity::Build.create
        end
      end
    end
  end
end
