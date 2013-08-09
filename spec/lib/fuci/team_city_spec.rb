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
    it 'is a reader' do
      project = 'project'
      Fuci::TeamCity.instance_variable_set :@project, project

      expect(Fuci::TeamCity.project).to_equal project

      Fuci::TeamCity.instance_variable_set :@project, nil
    end
  end

  describe '#project=' do
    it 'sets @project to a project object with the project name passed in' do
      Fuci::TeamCity::Project.stubs(:by_name).
        with(project_name = 'name').
        returns constructed_project = mock

      Fuci::TeamCity.project = project_name

      project = Fuci::TeamCity.instance_variable_get :@project
      expect(project).to_equal constructed_project

      Fuci::TeamCity.instance_variable_set :@project, nil
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
