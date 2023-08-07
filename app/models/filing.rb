# frozen_string_literal: true

class Filing < ApplicationRecord
  belongs_to :filer, inverse_of: :filings
  has_many :awards, inverse_of: :filing
  has_many :recipients, through: :awards
end
