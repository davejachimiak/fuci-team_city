require_relative '../../../spec_helper'
require_relative '../../../../lib/fuci/team_city/server'

stub_class 'Fuci::TeamCity::Build' do
  public
  def self.create
  end
end

describe Fuci::TeamCity::Server do
  before do
    Fuci::TeamCity::Build.stubs(:create).
      returns @build = mock
    @server = Fuci::TeamCity::Server.new
  end

  describe 'composition' do
    it 'inherits from Fuci::Server' do
      expect(@server).to_be_kind_of Fuci::Server
    end
  end

  describe '#initialize' do
    it 'sets build' do
      expect(@server.build).to_equal @build
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
      @server.stubs(:build).returns build = mock
      build.stubs(:log).returns log = mock

      expect(@server.fetch_log).to_equal log
    end
  end
end
