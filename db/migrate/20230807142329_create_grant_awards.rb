# frozen_string_literal: true

##
# @todo: Is recipient required? Can an award simply be tied to
# an organization to provide a browsing interface for available
# awards?

class CreateGrantAwards < ActiveRecord::Migration[7.0]
  def change
    create_table :grant_awards do |t|
      t.float      :amount,         null: false, default: 0.0, precision: 12, scale: 2
      t.belongs_to :filing,         null: false
      t.belongs_to :recipient,      null: false
      t.timestamps
    end
  end
end
