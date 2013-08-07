require_relative '../../../spec_helper'
stub_class 'Fuci::Server'
require_relative '../../../../lib/fuci/team_city/server'

describe Fuci::TeamCity::Server do
  describe 'composition' do
    it 'inherits from Fuci::Server' do
      server = Fuci::TeamCity::Server.new
      expect(server).to_be_kind_of Fuci::Server
    end
  end
end
