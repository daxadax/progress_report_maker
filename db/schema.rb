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

ActiveRecord::Schema.define(:version => 20130822125649) do

  create_table "characteristics", :force => true do |t|
    t.string   "characteristic"
    t.integer  "student_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "evaluations", :force => true do |t|
    t.integer  "score"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "student_id"
    t.integer  "goal_id"
  end

  add_index "evaluations", ["goal_id"], :name => "index_evaluations_on_goal_id"
  add_index "evaluations", ["student_id"], :name => "index_evaluations_on_student_id"

  create_table "goals", :force => true do |t|
    t.string   "goal"
    t.integer  "subject_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "default"
  end

  add_index "goals", ["subject_id"], :name => "index_goals_on_subject_id"

  create_table "student_groups", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "type_of_group"
  end

  add_index "student_groups", ["user_id"], :name => "index_student_groups_on_user_id"

  create_table "students", :force => true do |t|
    t.string   "name"
    t.string   "gender"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "student_group_id"
  end

  add_index "students", ["student_group_id"], :name => "index_students_on_student_group_id"

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.string   "end_date"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "student_group_id"
    t.string   "start_date"
    t.integer  "contact_time"
  end

  add_index "subjects", ["student_group_id"], :name => "index_subjects_on_student_group_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
