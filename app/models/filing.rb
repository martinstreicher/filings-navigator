# frozen_string_literal: true

class Filing < ApplicationRecord
  belongs_to :filer, inverse_of: :filings
  has_many :awards, inverse_of: :filing
  has_many :recipients, through: :awards

  def self.valid_for_tax_period(tax_period)
    return Filing.none if tax_period.nil?

    where(tax_period: tax_period)
      .order(amended_return: :desc, return_timestamp: :desc)
      .limit(1)
  end
end
