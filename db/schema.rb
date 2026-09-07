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

ActiveRecord::Schema[8.1].define(version: 2026_09_05_141307) do
  create_table "ledger_entries", force: :cascade do |t|
    t.decimal "amount", precision: 15, scale: 2
    t.datetime "created_at", null: false
    t.string "description"
    t.string "entry_type"
    t.string "reference_id"
    t.datetime "updated_at", null: false
    t.integer "wallet_id", null: false
    t.index ["wallet_id"], name: "index_ledger_entries_on_wallet_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "wallets", force: :cascade do |t|
    t.decimal "balance", precision: 15, scale: 2
    t.datetime "created_at", null: false
    t.string "currency"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "ledger_entries", "wallets"
  add_foreign_key "wallets", "users"
end
