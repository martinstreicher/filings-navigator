class CreateFilings < ActiveRecord::Migration[7.0]
  def change
    create_table :filings do |t|
      t.belongs_to :filer,            null: false
      t.datetime   :return_timestamp, null: false, index: true
      t.date       :tax_period,       null: false, index: true
      t.timestamps
    end
  end
end
