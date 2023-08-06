# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IrsReturn2015V21 do
  subject(:parser) { described_class.new(xml_file_url: url) }

  let(:class_name) { 'IrsReturn2015V21' }
  let(:date)       { '2015-12-31' }
  let(:result)     { ParseXmlInteractor.call(xml_file_url: url).result }
  let(:url)        { 'https://filing-service.s3-us-west-2.amazonaws.com/990-xmls/201612429349300846_public.xml' }

  describe 'when reading a format 2015 V2.1 return from a URL', aggregate_failures: true do
    it 'yields the correct attributes' do
      expect(result.name).to eq('Pasadena Community Foundation')
      expect(result.ein).to eq('200253310')
      expect(result.line1).to eq('301 E Colorado Blvd No 810')
      expect(result.return_timestamp).to eq('2016-08-29T15:59:11-05:00')
      expect(result.tax_period).to eq(date)
      expect(result.city).to eq('Pasadena')
      expect(result.state).to eq('CA')
      expect(result.zip).to eq('91101')
    end
  end
end
