# frozen_string_literal: true

##
# @todo: Decompose filer, address, and awards into separate classes
#
class IrsReturn2015V21 < BaseReturnObject
  include Memery

  AWARD_LIST_PATH =
    %i[
      irs990_schedule_i
      recipient_table
    ].freeze

  RETURN_DATA_PATH =
    %i[
      return
      return_data
    ].freeze

  RETURN_HEADER_PATH =
    %i[
      return
      return_header
    ].freeze

  def initialize(irs_return_as_hash)
    @irs_return_as_hash = irs_return_as_hash
  end

  memoize def address
    diggin('{USAddress,AddressUS}', data: filer, options: { underscore: true })
  end

  memoize def award_list
    return_data.dig(*self.class::AWARD_LIST_PATH).map do |award|
      Award.new(award)
    end
  end

  def city
    diggin('{City,CityNm}', data: address, options: { underscore: true })
  end

  def ein
    filer.dig(:ein)
  end

  memoize def filer
    return_header.dig(:filer)
  end

  memoize def filing
    return_header
  end

  def line1
    diggin('{AddressLine1,AddressLine1Txt}', data: address, options: { underscore: true })
  end

  def name
    diggin(
      '{Name,BusinessName}/{BusinessNameLine1,BusinessNameLine1Txt}',
      data:    filer,
      options: { underscore: true }
    )
  end

  def return_timestamp
    filing.dig(:return_ts)
  end

  def state
    diggin('{State,StateAbbreviationCd}', data: address, options: { underscore: true })
  end

  def tax_period
    diggin('{TaxPeriodEndDt,TaxPeriodEndDate}', data: filing, options: { underscore: true })
  end

  def zip
    diggin('{ZIPCode,ZIPCd}', data: address, options: { underscore: true })
  end

  alias zip_code zip
  alias zipcode zip

  private

  memoize def return_data
    irs_return_as_hash.dig(*self.class::RETURN_DATA_PATH)
  end

  memoize def return_header
    irs_return_as_hash.dig(*self.class::RETURN_HEADER_PATH)
  end

  attr_reader :irs_return_as_hash
end
