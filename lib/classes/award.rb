# frozen_string_literal: true

class Award < BaseReturnObject
  def initialize(award_as_hash)
    @award_as_hash = award_as_hash
  end

  def amended_return
    award_as_hash.dig(:amended_return_ind)
  end

  private

  attr_reader :award_as_hash
end
