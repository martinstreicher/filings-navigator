# frozen_string_literal: true

class Recipient < ApplicationRecord
  has_many :awards, inverse_of: :recipient
  has_many :filings, through: :awards
end
