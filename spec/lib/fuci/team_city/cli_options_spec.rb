require_relative '../../../spec_helper'
require_relative '../../../../lib/fuci/team_city/cli_options'

describe Fuci::TeamCity::CliOptions do
  describe '.branch' do
    before { @argv = Fuci::TeamCity::CliOptions.stubs :argv }

    describe 'when a branch is passed in' do
      before { @argv.returns [@branch = 'cool_ci_branch'] }

      it 'returns the first argument of argv' do
        expect(Fuci::TeamCity::CliOptions.branch).to_equal @branch
      end
    end

    describe 'when a branch is not passed in' do
      before { @argv.returns [] }

      it 'returns nil' do
        expect(Fuci::TeamCity::CliOptions.branch).to_be_nil
      end
    end
  end

  describe '.argv' do
    it 'delegates to Fuci::CliOptions' do
      Fuci::CliOptions.stubs(:argv).returns argv = ['an option']
      expect(Fuci::TeamCity::CliOptions.argv).to_equal argv
    end
  end
end
