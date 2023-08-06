# frozen_string_literal: true

require 'fileutils'
require 'open-uri'

##
# Open, read, parse an XML file given its URL, and
# return an object representing its contents.

class ParseXmlInteractor < BaseInteractor
  validates :xml_file_url, presence: true

  def execute
    context.fail!(errors: errors) if klass.blank?
    context.result = klass.new(parse)
  end

  private

  memoize def klass
    "IrsReturn#{version || '2015V21'}".safe_constantize
  end

  memoize def data
    URI.open(context.xml_file_url).read
  end

  ##
  # @todo:
  #   - Replace loading the entire XML file into memory with a SAX parser

  def parse
    xml = Ox.load(data, mode: :hash_no_attrs)
    xml.deep_transform_keys { |key| key.to_s.underscore.to_sym }
  end

  def version
    xml = Ox.load(data, mode: :hash)
    xml[:Return].first[:returnVersion]&.upcase&.tr('.', '')
  end
end
