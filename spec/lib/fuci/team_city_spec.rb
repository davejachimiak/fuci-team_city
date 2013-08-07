require_relative '../../spec_helper'
require_relative '../../../lib/fuci/team_city'

describe Fuci::TeamCity do
  describe 'composition' do
    it 'includes Fuci::Configurable' do
      expect(Fuci::TeamCity.ancestors).to_include Fuci::Configurable
    end
  end
end
