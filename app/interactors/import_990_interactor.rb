# frozen_string_literal: true

class Import990Interactor < BaseInteractor
  validates :xml_file_url, presence: true

  def execute
    service = ParseXmlInteractor.call(xml_file_url: xml_file_url)
    raise service.errors unless service.success?

    result = service.result
    filer  = Filer.new result.filer_attributes
    filing = Filing.new result.filing_attributes.merge(filer: filer)

    awards = result.award_list.map do |award|
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
