require_relative '../../../spec_helper'
require_relative '../../../../lib/fuci/team_city/build'

stub_class 'Fuci::TeamCity::CliOptions'

describe Fuci::TeamCity::Build do
  before do
    @branch_name = 'branch_name'
    @build       = Fuci::TeamCity::Build.new @branch_name
  end

  describe '#initialize' do
    it 'sets the branch_name' do
      expect(@build.branch_name).to_equal @branch_name
    end
  end

  describe '#build' do
    it 'is a memoized construction of the build info' do
      @build.stubs(:construct_build).returns constructed_build = mock
      expect(@build.build).to_equal constructed_build
    end
  end

  describe '#construct_build' do
    it 'calls #latest_build_from on #project' do
      @build.stubs(:project).returns project = mock
      project.stubs(:latest_build_from).
        with(@branch_name).
        returns latest_build = mock

      expect(@build.send :construct_build ).to_equal latest_build
    end
  end

  describe '#project' do
    it 'delegates to Fuci::TeamCity.project' do
      Fuci::TeamCity.stubs(:project).returns project = 'project'
      expect(@build.send :project ).to_equal project
    end
  end

  describe '.create' do
    before do
      @branch = Fuci::TeamCity::CliOptions.stubs :branch
    end

    describe 'when a branch is passed in the cli' do
      before do
        @branch_name    = 'branch'
        @branch.returns @branch_name
      end

      it 'creates a new build with the branch passed in' do
        Fuci::TeamCity::Build.stubs(:new).
          with(@branch_name).
          returns build = mock
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
          Fuci::TeamCity::Build.stubs(:new).
            with(@branch_name).
            returns build = mock

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
