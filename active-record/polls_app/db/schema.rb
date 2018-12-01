ActiveRecord::Schema.define(version: 20170714041140) do
    enable_extension "plpgsql"
  
    create_table "answer_choices", force: :cascade do |t|
      t.string "text", null: false
      t.integer "question_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["question_id"], name: "index_answer_choices_on_question_id"
    end
  
    create_table "polls", force: :cascade do |t|
      t.string "title", null: false
      t.integer "author_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["author_id"], name: "index_polls_on_author_id"
    end
  
    create_table "questions", force: :cascade do |t|
      t.string "text", null: false
      t.integer "poll_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["poll_id"], name: "index_questions_on_poll_id"
    end
  
    create_table "responses", force: :cascade do |t|
      t.integer "answer_choice_id", null: false
      t.integer "respondent_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["answer_choice_id"], name: "index_responses_on_answer_choice_id"
      t.index ["respondent_id"], name: "index_responses_on_respondent_id"
    end
  
    create_table "users", force: :cascade do |t|
      t.string "username", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["username"], name: "index_users_on_username", unique: true
    end
  
  end
  