class Import990Interactor < BaseInteractor
  validstes :xml_file_url, presence: true

  def execute
    result = ParseXmlInteractor.call(xml_file_url: xml_file_url).result
    raise result.errors unless result.success?

  end
end
