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

ActiveRecord::Schema[8.0].define(version: 2025_04_15_195207) do
  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", primary_key: "CRN", force: :cascade do |t|
    t.string "class_name", null: false
    t.string "professor", null: false
    t.string "term", null: false
    t.integer "credits", null: false
    t.time "class_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "major"
    t.string "status"
    t.string "prerequisite"
    t.boolean "mon", default: false
    t.boolean "tue", default: false
    t.boolean "wed", default: false
    t.boolean "thu", default: false
    t.boolean "fri", default: false
    t.time "end_time"
    t.integer "volume", default: 0, null: false
    t.integer "capacity", default: 0, null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "student_id", null: false
    t.string "message", null: false
    t.boolean "read", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "body"
    t.index ["student_id"], name: "index_notifications_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.integer "credits_earned", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "major"
    t.integer "notifications"
  end

  create_table "user_schedules", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "course_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "term"
    t.index ["course_id"], name: "index_user_schedules_on_course_id"
    t.index ["student_id"], name: "index_user_schedules_on_student_id"
  end

  add_foreign_key "notifications", "students"
  add_foreign_key "user_schedules", "courses", primary_key: "CRN"
  add_foreign_key "user_schedules", "students"
end
