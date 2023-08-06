# frozen_string_literal: true

class IrsReturn2015V21 < BaseReturn
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

  def award_list
    return_data.dig(*self.class::AWARD_LIST_PATH)
  end

  memoize def filer
    return_header.dig(:filer)
  end

  memoize def filing
    return_header
  end

  def return_date
    filing.dig(:return_ts)
  end

  private

  memoize def return_data
    irs_return_as_hash.dig(*self.class::RETURN_DATA_PATH)
  end

  memoize def return_header
    irs_return_as_hash.dig(*self.class::RETURN_HEADER_PATH)
  end

  attr_reader :irs_return_as_hash
end
