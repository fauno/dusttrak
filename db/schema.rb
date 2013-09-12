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

ActiveRecord::Schema.define(:version => 9) do

  create_table "aparatos", :force => true do |t|
    t.string   "nombre"
    t.text     "observaciones"
    t.integer  "grd"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.float    "escala",        :default => 3.2
    t.integer  "cero",          :default => 3996
  end

  create_table "configuraciones", :force => true do |t|
    t.float    "umbral",     :default => 0.3
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "mediciones", :force => true do |t|
    t.integer  "grd_id",        :null => false
    t.float    "concentracion", :null => false
    t.integer  "valor",         :null => false
    t.datetime "created_at",    :null => false
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
