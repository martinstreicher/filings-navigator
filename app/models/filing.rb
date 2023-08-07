# frozen_string_literal: true

class Filing < ApplicationRecord
  belongs_to :filer, foreign_key: :organization_id, inverse_of: :filings
  has_many :awards, inverse_of: :filing
  has_many :recipients, through: :awards
end
