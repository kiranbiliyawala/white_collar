# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 7) do

  create_table "fk_user_profiles", :force => true do |t|
    t.string  "fkuid"
    t.string  "name"
    t.string  "gender"
    t.string  "city"
    t.string  "state"
    t.integer "age"
  end

  create_table "flipkart_linkedins", :force => true do |t|
    t.string "fkuid"
    t.string "lnid"
  end

  create_table "ln_connections", :force => true do |t|
    t.string "fkuid_from"
    t.string "fkuid_to"
  end

  create_table "order_infos", :force => true do |t|
    t.string   "fkuid"
    t.string   "fsn"
    t.string   "category"
    t.datetime "order_date"
  end

  create_table "user_occupation_histories", :force => true do |t|
    t.string   "fkuid"
    t.string   "designation"
    t.string   "company"
    t.datetime "date"
  end

end
