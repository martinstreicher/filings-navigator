# frozen_string_literal: true

class Import990Interactor < BaseInteractor
  validates :xml_file_url, presence: true

  def execute
    service = ParseXmlInteractor.call(xml_file_url: xml_file_url)
    raise service.errors unless service.success?

    result = service.result
    filer  = Filer.find_or_create_by result.filer_attributes
    filing = Filing.find_or_create_by result.filing_attributes.merge(filer: filer)

    awards = result.award_list.map do |award|
      recipient = Recipient.find_or_create_by award.recipient_attributes

      GrantAward.new(
        award.award_attributes
          .merge(recipient: recipient)
          .merge(filing: filing)
        )
    end

    GrantAward.import(
      awards,
      validate: true,
      validate_uniqueness: treue
    )
  end
end
