require_relative '../../spec_helper'

module Fuci
  def self.configure; end;
end

require_relative '../../../lib/fuci/team_city'
stub_class 'Fuci::TeamCity::Project'

describe Fuci::TeamCity do
  describe 'composition' do
    it 'includes Fuci::Configurable' do
      expect(Fuci::TeamCity.ancestors).to_include Fuci::Configurable
    end
  end

  describe '#host' do
    it('is an accessor') { assert_accessor :host }
  end

  describe '#username' do
    it('is an accessor') { assert_accessor :username }
  end

  describe '#password' do
    it('is an accessor') { assert_accessor :password }
  end

  describe '#default_branch' do
    it('is an accessor') { assert_accessor :default_branch }
  end

  describe '#project' do
    it('is an accessor') { assert_accessor :project }
  end

  describe '.add_testers' do
    it 'delegates to Fuci' do
      Fuci.expects(:add_testers).with testers = mock
      Fuci::TeamCity.add_testers testers
    end
  end
end

def assert_accessor accessor
  object = Object.new

  expect(Fuci::TeamCity.send accessor).to_be_nil
  Fuci::TeamCity.send :"#{accessor.to_s}=", object
  expect(Fuci::TeamCity.send accessor).to_equal object

  Fuci::TeamCity.instance_variable_set :"@#{accessor.to_s}", nil
end
