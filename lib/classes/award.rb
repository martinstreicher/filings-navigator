# frozen_string_literal: true

class Award < BaseReturnObject
  def initialize(award_as_hash)
    @award_as_hash = award_as_hash
  end

  memoize def address
    diggin('{USAddress,AddressUS}', data: award_as_hash, options: { underscore: true })
  end

  def amount
    diggin(
      '{AmountOfCashGrant,CashGrantAmt}',
      data: award_as_hash,
      options: { underscore: true }
    )
  end

  def amended_return?
    award_as_hash[:amended_return_ind].present?
  end

  def award_attributes
    {
      amount:         amount,
    }
  end

  def ein
    diggin(
      '{EINOfRecipient,RecipientEIN}',
      data:    award_as_hash,
      options: { underscore: true }
    )
  end

  def recipient_attributes
    {
      name:    recipient_name,
      ein:     ein,
      line1:   line1,
      city:    city,
      state:   state,
      zipcode: zip
    }
  end

  def recipient_name
    diggin(
      '{RecipientNameBusiness,RecipientBusinessName}/{BusinessNameLine1,BusinessNameLine1Txt}',
      data:    award_as_hash,
      options: { underscore: true }
    )
  end

  private

  attr_reader :award_as_hash
end
