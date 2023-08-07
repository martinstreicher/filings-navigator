# frozen_string_literal: true

class GrantAward < ApplicationRecord
  belongs_to :filing
  belongs_to :recipient
end
