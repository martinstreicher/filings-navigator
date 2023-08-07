class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    %i[filers recipients].each do |table|
      create_table table do |t|
        t.string :city,    null: false
        t.string :ein,     null: false, index: true
        t.string :line1,   null: false
        t.string :name,    null: false, index: true
        t.string :state,   null: false
        t.string :zipcode, null: false

        t.timestamps
      end
    end
  end
end
