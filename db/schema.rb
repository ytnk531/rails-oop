# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_03_200347) do

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "fees", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.integer "hourly_rate"
    t.integer "monthly_salary"
    t.integer "commission_rate"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_fees_on_employee_id"
  end

  create_table "sales_receipts", force: :cascade do |t|
    t.date "date"
    t.integer "amount"
    t.integer "fee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fee_id"], name: "index_sales_receipts_on_fee_id"
  end

  create_table "timecards", force: :cascade do |t|
    t.integer "fee_id", null: false
    t.date "date"
    t.integer "hours"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fee_id"], name: "index_timecards_on_fee_id"
  end

  add_foreign_key "fees", "employees"
  add_foreign_key "timecards", "fees"
end
