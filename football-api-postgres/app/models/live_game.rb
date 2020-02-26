class LiveGame < ApplicationRecord
    def self.seed
        LiveGame.destroy_all

        live_games = RestClient::Request.execute(
        method: :get,
        url: 'https://api-football-v1.p.rapidapi.com/v2/fixtures/live',
        headers:{
        "x-rapidapi-key": ""
        })

        parsed_live_games = JSON.parse(live_games)
        parsed_live_games["api"]["fixtures"].each do |game|
            livegame = LiveGame.new
            livegame.flag = game["league"]["flag"]
            livegame.elapsed = game["elapsed"]
            livegame.home_goals = game["goalsHomeTeam"]
            livegame.away_goals = game["goalsAwayTeam"]
            livegame.home_team = game["homeTeam"]["team_name"]
            livegame.away_team = game["awayTeam"]["team_name"]
            livegame.home_crest = game["homeTeam"]["logo"]
            livegame.away_crest = game["awayTeam"]["logo"]
            livegame.save
        end
        puts "LiveGames seeded"
    end
end
