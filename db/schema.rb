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

ActiveRecord::Schema.define(:version => 20111211195046) do

  create_table "memberships", :force => true do |t|
    t.integer  "person_id",       :null => false
    t.integer  "organisation_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["person_id", "organisation_id"], :name => "index_memberships_on_person_id_and_organisation_id", :unique => true

  create_table "organisations", :force => true do |t|
    t.string   "website"
    t.string   "address"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participations", :force => true do |t|
    t.integer  "person_id",  :null => false
    t.integer  "webinar_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participations", ["person_id", "webinar_id"], :name => "index_participations_on_person_id_and_webinar_id", :unique => true

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "email",                                      :null => false
    t.boolean  "verified_for_webinar",    :default => false, :null => false
    t.boolean  "participated_in_webinar", :default => false, :null => false
    t.boolean  "received_login",          :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "reason_to_participate"
  end

  add_index "people", ["email"], :name => "index_people_on_email", :unique => true

  create_table "webinars", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "start"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
