require_relative '../../../spec_helper'
require_relative '../../../../lib/fuci/team_city/build'

stub_class 'Fuci::TeamCity::CliOptions'

describe Fuci::TeamCity::Build do
  describe '#initialize' do
    it 'sets the branch_name' do
      build = Fuci::TeamCity::Build.new branch_name = 'branch_name'
      expect(build.branch_name).to_equal branch_name
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
