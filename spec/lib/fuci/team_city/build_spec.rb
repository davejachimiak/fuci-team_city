require_relative '../../../spec_helper'
require_relative '../../../../lib/fuci/team_city/build'

stub_class 'Fuci::TeamCity::CliOptions'

describe Fuci::TeamCity::Build do
  describe '.create' do
    describe 'when a branch is passed in the cli' do
      before do
        Fuci::TeamCity::CliOptions.stubs(:branch).
          returns @branch = 'branch'
      end

      it 'creates a new build with the branch passed in' do
        Fuci::TeamCity::Build.stubs(:new).
          with(@branch).
          returns build = mock
        expect(Fuci::TeamCity::Build.create).to_equal build
      end
    end

    describe 'when a branch is not passed in the cli' do
      describe 'when a default branch is configured' do
      end

      describe 'when a branch is not configured' do
      end
    end
  end
end
