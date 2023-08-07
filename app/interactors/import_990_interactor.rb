class Import990Interactor < BaseInteractor
  validstes :xml_file_url, presence: true

  def execute
    result = ParseXmlInteractor.call(xml_file_url: xml_file_url).result
    raise result.errors unless result.success?

    filer  = Filer.new result.filer_attributes
    filing = Filing.new result.filing_attributes.merge(filer: filer)

    awards = result.awards.map do |award|
      recipient = Recipient.new award.recipient_attributes

      GrantAward.new(
        award.award_attributes
          .merge(recipient: recipient)
          .merge(filing: filing)
        )
    end

    GrantAward.import(
      awards,
      validate: true,
      validate_uniqueness: true,
      recursive: true
    )
  end
end
