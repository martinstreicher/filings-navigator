# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ParseXmlInteractor do
  subject(:parser) { described_class.call(xml_file_url: url) }

  let(:class_name)  { 'IrsReturn2015V21' }
  let(:result)      { parser.result }
  let(:url)         { 'https://filing-service.s3-us-west-2.amazonaws.com/990-xmls/201612429349300846_public.xml' }

  describe 'when reading a file from a URL', aggregate_failures: true do
    it 'returns an object representing the return' do
      expect(result.class.name).to eq(class_name)
      expect(result.filer.keys).to include(:ein, :business_name)
      expect(result.award_list).to be_a(Array)
      debugger
    end
  end
end
