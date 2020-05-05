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

ActiveRecord::Schema.define(version: 2020_05_05_193626) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "album_tracks", force: :cascade do |t|
    t.bigint "track_id", null: false
    t.bigint "album_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["album_id"], name: "index_album_tracks_on_album_id"
    t.index ["track_id"], name: "index_album_tracks_on_track_id"
  end

  create_table "albums", force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.string "upc"
    t.string "release_title"
    t.integer "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cover_art_url"
    t.index ["artist_id"], name: "index_albums_on_artist_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sales", force: :cascade do |t|
    t.string "saleable_type", null: false
    t.bigint "saleable_id", null: false
    t.string "transaction_type"
    t.float "label_share"
    t.float "artist_share"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "revenue"
    t.string "period"
    t.string "activity_period"
    t.string "territory"
    t.index ["saleable_type", "saleable_id"], name: "index_sales_on_saleable_type_and_saleable_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.string "isrc"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id"], name: "index_tracks_on_artist_id"
  end

  add_foreign_key "album_tracks", "albums"
  add_foreign_key "album_tracks", "tracks"
  add_foreign_key "albums", "artists"
  add_foreign_key "tracks", "artists"
end
