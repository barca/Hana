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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141129035506) do

  create_table "classrooms", force: true do |t|
    t.string   "name"
    t.integer  "max_occupancy"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "color"
  end

  create_table "lessons", force: true do |t|
    t.string   "title"
    t.string   "instructor"
    t.string   "location"
    t.integer  "max_enrollment"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "g1_3"
    t.boolean  "g3_5"
    t.boolean  "g6_8"
    t.boolean  "mon"
    t.boolean  "tue"
    t.boolean  "wed"
    t.boolean  "thu"
    t.boolean  "fri"
    t.date     "end_date"
    t.string   "color"
    t.time     "starts_at"
    t.time     "ends_at"
    t.date     "start_date"
  end

end
