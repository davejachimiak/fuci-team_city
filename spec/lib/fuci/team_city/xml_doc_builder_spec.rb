require_relative '../../../spec_helper'
require_relative '../../../../lib/fuci/team_city/xml_doc_builder'

stub_class 'Fuci::TeamCity::Request'

describe Fuci::TeamCity::XmlDocBuilder do
  describe '.from_resource' do
    it 'returns an xml document from the resource passed in' do
      response = '<response/>'
      resource = "/httpAuth/app/rest"
      Fuci::TeamCity::Request.stubs(:new).
        with(resource).returns request = mock
      request.stubs(:call).returns response
      Nokogiri.stubs(:XML).with(response).returns xml_doc = mock

      from_resource = Fuci::TeamCity::XmlDocBuilder.from_resource resource
      expect(from_resource).to_equal xml_doc
    end
  end
end
