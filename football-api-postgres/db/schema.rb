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

ActiveRecord::Schema.define(version: 2020_02_07_160131) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "date"
    t.string "home_team"
    t.string "away_team"
    t.integer "score_home"
    t.integer "score_away"
    t.string "result"
    t.string "stadium"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "season"
  end

  create_table "live_games", force: :cascade do |t|
    t.string "flag"
    t.integer "elapsed"
    t.integer "home_goals"
    t.integer "away_goals"
    t.string "home_team"
    t.string "away_team"
    t.string "home_crest"
    t.string "away_crest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "position"
    t.string "name"
    t.string "image"
    t.integer "games_played"
    t.float "goals_per_game"
    t.float "assists_per_game"
    t.float "big_chances_created_per_game"
    t.integer "shooting_accuracy"
    t.float "conceded_per_game"
    t.float "tackles_per_game"
    t.integer "tackle_accuracy"
    t.float "errors_leading_to_goals_per_game"
    t.integer "interceptions_per_game"
    t.integer "aerial_win_rate"
    t.integer "through_balls_per_game"
    t.float "passes_per_game"
    t.integer "save_percentage"
    t.integer "penalty_kick_save_percentage"
    t.integer "accurate_long_balls_per_game"
    t.integer "team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "standings", force: :cascade do |t|
    t.string "position"
    t.string "name"
    t.string "crest"
    t.integer "played_games"
    t.integer "won_games"
    t.integer "drawn_games"
    t.integer "lost_games"
    t.integer "points"
    t.integer "goals_for"
    t.integer "goals_against"
    t.integer "goal_difference"
  end

  create_table "teamgames", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "game_id"
    t.index ["game_id"], name: "index_teamgames_on_game_id"
    t.index ["team_id"], name: "index_teamgames_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.integer "team_id"
    t.string "name"
    t.string "code"
    t.string "logo"
    t.string "country"
    t.string "founded"
    t.string "stadium_name"
    t.string "venue_surface"
    t.string "venue_address"
    t.string "venue_city"
    t.integer "venue_capacity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
  end

end
