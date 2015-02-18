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

ActiveRecord::Schema.define(version: 20150217231224) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer  "question_id"
    t.text     "text"
    t.text     "short_text"
    t.text     "help_text"
    t.integer  "weight"
    t.string   "response_class"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.integer  "display_order"
    t.boolean  "is_exclusive"
    t.integer  "display_length"
    t.string   "custom_class"
    t.string   "custom_renderer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "default_value"
    t.string   "api_id"
    t.string   "display_type"
    t.string   "input_mask"
    t.string   "input_mask_placeholder"
    t.string   "original_choice"
    t.boolean  "is_comment",             default: false
    t.integer  "column_id"
  end

  add_index "answers", ["api_id"], name: "uq_answers_api_id", unique: true, using: :btree

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "token_secret"
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "columns", force: true do |t|
    t.integer  "question_group_id"
    t.text     "text"
    t.text     "answers_textbox"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dependencies", force: true do |t|
    t.integer  "question_id"
    t.integer  "question_group_id"
    t.string   "rule"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dependency_conditions", force: true do |t|
    t.integer  "dependency_id"
    t.string   "rule_key"
    t.integer  "question_id"
    t.string   "operator"
    t.integer  "answer_id"
    t.datetime "datetime_value"
    t.integer  "integer_value"
    t.float    "float_value"
    t.string   "unit"
    t.text     "text_value"
    t.string   "string_value"
    t.string   "response_other"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "column_id"
  end

  create_table "exploration_invitations", force: true do |t|
    t.integer  "user_id"
    t.string   "friend_email"
    t.string   "accept"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "exploration_id"
  end

  create_table "exploration_users", force: true do |t|
    t.integer  "exploration_id"
    t.integer  "user_id"
    t.datetime "started"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
    t.datetime "completed"
  end

  create_table "explorations", force: true do |t|
    t.string   "category"
    t.string   "picture"
    t.integer  "completions_required"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "explorer_id"
    t.integer  "steps"
    t.datetime "end_date"
    t.string   "title"
    t.text     "description"
    t.string   "short_description"
  end

  create_table "explorers", force: true do |t|
    t.integer  "user_id"
    t.string   "last_name"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "problems", force: true do |t|
    t.integer  "exploration_id"
    t.text     "problem_one"
    t.text     "problem_two"
    t.text     "problem_three"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_groups", force: true do |t|
    t.text     "text"
    t.text     "help_text"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.string   "display_type"
    t.string   "custom_class"
    t.string   "custom_renderer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "api_id"
  end

  add_index "question_groups", ["api_id"], name: "uq_question_groups_api_id", unique: true, using: :btree

  create_table "questions", force: true do |t|
    t.integer  "survey_section_id"
    t.integer  "question_group_id"
    t.text     "text"
    t.text     "short_text"
    t.text     "help_text"
    t.string   "pick"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.integer  "display_order"
    t.string   "display_type"
    t.boolean  "is_mandatory"
    t.integer  "display_width"
    t.string   "custom_class"
    t.string   "custom_renderer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "correct_answer_id"
    t.string   "api_id"
    t.boolean  "modifiable",             default: true
    t.boolean  "dynamically_generate",   default: false
    t.string   "dummy_blob"
    t.string   "dynamic_source"
    t.string   "report_code"
    t.boolean  "is_comment",             default: false
  end

  add_index "questions", ["api_id"], name: "uq_questions_api_id", unique: true, using: :btree

  create_table "response_sets", force: true do |t|
    t.integer  "user_id"
    t.integer  "survey_id"
    t.string   "access_code"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "api_id"
    t.boolean  "test_data",    default: false
  end

  add_index "response_sets", ["access_code"], name: "response_sets_ac_idx", unique: true, using: :btree
  add_index "response_sets", ["api_id"], name: "uq_response_sets_api_id", unique: true, using: :btree

  create_table "responses", force: true do |t|
    t.integer  "response_set_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "datetime_value"
    t.integer  "integer_value"
    t.float    "float_value"
    t.string   "unit"
    t.text     "text_value"
    t.string   "string_value"
    t.string   "response_other"
    t.string   "response_group"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "survey_section_id"
    t.string   "api_id"
    t.string   "blob"
    t.integer  "column_id"
  end

  add_index "responses", ["api_id"], name: "uq_responses_api_id", unique: true, using: :btree
  add_index "responses", ["survey_section_id"], name: "index_responses_on_survey_section_id", using: :btree

  create_table "rows", force: true do |t|
    t.integer  "question_group_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_sections", force: true do |t|
    t.integer  "survey_id"
    t.string   "title"
    t.text     "description"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.integer  "display_order"
    t.string   "custom_class"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "modifiable",             default: true
  end

  create_table "survey_translations", force: true do |t|
    t.integer  "survey_id"
    t.string   "locale"
    t.text     "translation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "access_code"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.datetime "active_at"
    t.datetime "inactive_at"
    t.string   "css_url"
    t.string   "custom_class"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "display_order"
    t.string   "api_id"
    t.integer  "survey_version",         default: 0
    t.boolean  "template",               default: false
    t.integer  "user_id"
  end

  add_index "surveys", ["access_code", "survey_version"], name: "surveys_access_code_version_idx", unique: true, using: :btree
  add_index "surveys", ["api_id"], name: "uq_surveys_api_id", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                      default: "", null: false
    t.string   "encrypted_password",         default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",          default: 0
    t.integer  "invited_for_exploration_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "validation_conditions", force: true do |t|
    t.integer  "validation_id"
    t.string   "rule_key"
    t.string   "operator"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "datetime_value"
    t.integer  "integer_value"
    t.float    "float_value"
    t.string   "unit"
    t.text     "text_value"
    t.string   "string_value"
    t.string   "response_other"
    t.string   "regexp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "validations", force: true do |t|
    t.integer  "answer_id"
    t.string   "rule"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_url"
    t.integer  "user_id"
    t.string   "camera"
  end

  create_table "written_inputs", force: true do |t|
    t.integer  "user_id"
    t.integer  "exploration_id"
    t.text     "written_input"
    t.integer  "step"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
