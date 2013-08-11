require_relative '../../../spec_helper'
require_relative '../../../../lib/fuci/team_city/request'

stub_class 'Net::HTTP::Get'

describe Fuci::TeamCity::Request do
  before do
    @request = Fuci::TeamCity::Request.new @resource = 'resource'
  end

  describe '#initialize' do
    it 'sets the resource passed in' do
      expect(@request.resource).to_equal @resource
    end
  end

  describe '#call' do
    before do
      @body = 'body'
      @request.stubs(:start).returns OpenStruct.new(body: @body)
      @request.stubs(:request_obj).returns request_obj = mock
      @request.stubs(:username).returns username = 'username'
      @request.stubs(:password).returns password = 'password'
      request_obj.expects(:basic_auth).with username, password
    end

    it 'it returns the body of the response' do
      expect(@request.call).to_equal @body
    end
  end

  describe '#request_obj' do
    it 'returns a HTTP::Get object' do
      @request.stubs(:uri).returns uri = mock
      Net::HTTP::Get.stubs(:new).with(uri).returns get = mock
      expect(@request.send :request_obj ).to_equal get
    end
  end

  describe '#username' do
    it 'delegates to Fuci::TeamCity' do
      Fuci::TeamCity.stubs(:username).returns username = 'username'
      expect(@request.send :username ).to_equal username
    end
  end

  describe '#password' do
    it 'delegates to Fuci::TeamCity' do
      Fuci::TeamCity.stubs(:password).returns password = 'password'
      expect(@request.send :password ).to_equal password
    end
  end

  describe '#uri' do
    it 'wraps the url passed in a URI' do
      base_url = 'base url'
      url      = base_url + @resource
      @request.stubs(:base_url).returns base_url
      @request.stubs(:URI).with(url).returns uri = mock

      expect(@request.send :uri ).to_equal uri
    end
  end

  describe '#base_url' do
    it 'concats the scheme and the domain' do
      @request.stubs(:scheme).returns scheme = 'http'
      @request.stubs(:host).returns host = 'www.domain.com'
      base_url = "#{scheme}://#{host}"

      expect(@request.send :base_url ).to_equal base_url
    end
  end

  describe '#scheme' do
    it 'returns http' do
      expect(@request.send :scheme ).to_equal 'http'
    end
  end

  describe '#host' do
    it 'delegates to Fuci::TeamCity' do
      Fuci::TeamCity.stubs(:host).returns host = 'host'
      expect(@request.send :host ).to_equal host
    end
  end

  describe '#start' do
    it 'starts a request with the uri hostname and uri port' do
      host = 'host'
      port = 8012
      uri  = OpenStruct.new(host: host, port: port)
      @request.stubs(:uri).returns uri
      Net::HTTP.expects(:start).with host, port

      @request.send :start
    end
  end
end
