# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090219152702) do

  create_table "works", :force => true do |t|
    t.string   "headline"
    t.text     "description"
    t.string   "file_name"
    t.string   "content_type"
    t.text     "other_content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.datetime "image_updated_at"
    t.integer  "image_file_size"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.datetime "thumbnail_updated_at"
    t.integer  "thumbnail_file_size"
  end

  create_table "works_rel_works", :id => false, :force => true do |t|
    t.integer "work_id",     :default => 0, :null => false
    t.integer "rel_work_id", :default => 0, :null => false
  end

end
