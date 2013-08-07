require_relative '../../../spec_helper'
stub_class 'Fuci::Server'
require_relative '../../../../lib/fuci/team_city/server'

describe Fuci::TeamCity::Server do
  before do
    @server = Fuci::TeamCity::Server.new
  end

  describe 'composition' do
    it 'inherits from Fuci::Server' do
      expect(@server).to_be_kind_of Fuci::Server
    end
  end

  describe '#build_status' do
    it 'delegates to #build' do
      @server.stubs(:build).returns build = mock
      build.stubs(:status).returns build_status = mock

      expect(@server.build_status).to_equal build_status
    end
  end

  describe '#fetch_log' do
    it 'delegates to #build' do
    end
  end
end
