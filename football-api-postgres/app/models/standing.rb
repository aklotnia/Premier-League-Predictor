class Standing < ApplicationRecord

    def self.seed
        self.destroy_all
        league_table = RestClient::Request.execute(
        method: :get,
        url: 'https://api.football-data.org/v2/competitions/2021/standings',
        headers:{
        "X-Auth-Token": ""
        })

        league_table_parsed = JSON.parse(league_table)
        league_table_parsed["standings"][0]["table"].each do |team|
            standing = self.new
            standing.position = team["position"]
            standing.name = team["team"]["name"]
            standing.crest = team["team"]["crestUrl"]
            standing.played_games = team["playedGames"]
            standing.won_games = team["won"]
            standing.drawn_games = team["draw"]
            standing.lost_games = team["lost"]
            standing.points = team["points"]
            standing.goals_for = team["goalsFor"]
            standing.goals_against = team["goalsAgainst"]
            standing.goal_difference = team["goalDifference"]
            standing.save
        end
    end

end
