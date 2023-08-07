# frozen_string_literal: true

class Award < ApplicationRecord
  belongs_to :filing
  belongs_to :recipient
end
