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

ActiveRecord::Schema.define(version: 20130930202048) do

  create_table "attachments", force: true do |t|
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "name"
    t.text     "description"
    t.string   "slug"
  end

  add_index "attachments", ["project_id"], name: "index_attachments_on_project_id", using: :btree

  create_table "clients", force: true do |t|
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "biography"
    t.string   "industry"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["project_id"], name: "index_clients_on_project_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "goals", force: true do |t|
    t.string   "copy"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "goalable_id"
    t.string   "goalable_type"
  end

  create_table "identity_guidelines", force: true do |t|
    t.string   "brand_image_file_name"
    t.string   "brand_image_content_type"
    t.integer  "brand_image_file_size"
    t.datetime "brand_image_updated_at"
    t.string   "background_image_file_name"
    t.string   "background_image_content_type"
    t.integer  "background_image_file_size"
    t.datetime "background_image_updated_at"
    t.string   "brand_name"
    t.text     "overview"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identity_guidelines", ["project_id"], name: "index_identity_guidelines_on_project_id", using: :btree

  create_table "influencers", force: true do |t|
    t.string   "name"
    t.decimal  "percentage"
    t.integer  "persona_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "influencers", ["persona_id"], name: "index_influencers_on_persona_id", using: :btree

  create_table "interests", force: true do |t|
    t.integer  "persona_id"
    t.string   "name"
    t.integer  "value",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "interests", ["persona_id"], name: "index_interests_on_persona_id", using: :btree

  create_table "personas", force: true do |t|
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "background_image_file_name"
    t.string   "background_image_content_type"
    t.integer  "background_image_file_size"
    t.datetime "background_image_updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.string   "occupation"
    t.string   "byline"
    t.text     "description"
    t.integer  "project_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "creative_commons_license",          default: "None"
    t.string   "creative_commons_attribution"
    t.string   "creative_commons_attribution_link"
  end

  add_index "personas", ["project_id"], name: "index_personas_on_project_id", using: :btree

  create_table "photos", force: true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "caption"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["project_id"], name: "index_photos_on_project_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "medium"
    t.string   "state",                         default: "pending"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "background_image_file_name"
    t.string   "background_image_content_type"
    t.integer  "background_image_file_size"
    t.datetime "background_image_updated_at"
    t.boolean  "experiment"
    t.date     "released_on"
    t.string   "url"
    t.string   "missing_url_reason"
    t.string   "main_image_file_name"
    t.string   "main_image_content_type"
    t.integer  "main_image_file_size"
    t.datetime "main_image_updated_at"
    t.integer  "lock_version",                  default: 0
  end

  create_table "technologies", force: true do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "personal_history"
    t.integer  "years_of_experience"
  end

  create_table "technology_profiles", force: true do |t|
    t.integer "technology_id"
    t.integer "project_id"
    t.integer "percentage_of_project"
  end

  add_index "technology_profiles", ["project_id"], name: "index_technology_profiles_on_project_id", using: :btree
  add_index "technology_profiles", ["technology_id"], name: "index_technology_profiles_on_technology_id", using: :btree

  create_table "testimonals", force: true do |t|
    t.text     "statement"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "testimonals", ["client_id"], name: "index_testimonals_on_client_id", using: :btree

end
