# frozen_string_literal: true

class Filer < ApplicationRecord
  has_many :filings, inverse_of: :filer
  has_many :rewards, through: :filings
  has_many :recipients, through: :rewards

  validates :name, presence: true
  validates :ein, presence: true, uniqueness: true
end
