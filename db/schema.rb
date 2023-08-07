# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_07_142339) do
  create_table "filers", force: :cascade do |t|
    t.string "city", null: false
    t.string "ein", null: false
    t.string "line1", null: false
    t.string "name", null: false
    t.string "state", null: false
    t.string "zipcode", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ein"], name: "index_filers_on_ein"
    t.index ["name"], name: "index_filers_on_name"
  end

  create_table "filings", force: :cascade do |t|
    t.integer "filer_id", null: false
    t.datetime "return_timestamp", null: false
    t.date "tax_period", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["filer_id"], name: "index_filings_on_filer_id"
    t.index ["return_timestamp"], name: "index_filings_on_return_timestamp"
    t.index ["tax_period"], name: "index_filings_on_tax_period"
  end

  create_table "grant_awards", force: :cascade do |t|
    t.boolean "amended_return", default: false, null: false
    t.float "amount", default: 0.0, null: false
    t.integer "filing_id", null: false
    t.integer "recipient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["filing_id"], name: "index_grant_awards_on_filing_id"
    t.index ["recipient_id"], name: "index_grant_awards_on_recipient_id"
  end

  create_table "recipients", force: :cascade do |t|
    t.string "city", null: false
    t.string "ein", null: false
    t.string "line1", null: false
    t.string "name", null: false
    t.string "state", null: false
    t.string "zipcode", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ein"], name: "index_recipients_on_ein"
    t.index ["name"], name: "index_recipients_on_name"
  end

end
