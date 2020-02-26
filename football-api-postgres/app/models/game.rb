require 'pycall/import'
include PyCall::Import


class Game < ApplicationRecord
    has_many :teamgames
    has_many :teams, through: :teamgames

    def self.poisson(hometeam, awayteam)
        hometeam = Team.find_by_name(hometeam)
        awayteam = Team.find_by_name(awayteam)

        total2019 = Game.where("season = '2019'")

        home_goals = total2019.map {|game| game.score_home}.compact
        away_goals = total2019.map {|game| game.score_away}.compact

        averagehomegoals =  home_goals.sum / home_goals.length.to_f
        averageawaygoals = away_goals.sum / away_goals.length.to_f

        averagehomeconceded = averageawaygoals
        averageawayconceded = averagehomegoals

        homegames = total2019.where(["home_team = ?", hometeam.name])
        awaygames = total2019.where(["away_team = ?", awayteam.name])

        home_goals_home_team = homegames.map {|game| game.score_home}.compact
        goals_conceded_home_team = homegames.map {|game| game.score_away}.compact

        goals_conceded_home_team_average = goals_conceded_home_team.sum / goals_conceded_home_team.length.to_f
        home_goals_home_team_average = home_goals_home_team.sum / home_goals_home_team.length.to_f

        attacking_strength_home_team = home_goals_home_team_average / averagehomegoals
        defensive_strength_home_team = goals_conceded_home_team_average / averagehomeconceded

        goals_conceded_away_team = awaygames.map {|game| game.score_home}.compact
        goals_scored_away_team = awaygames.map {|game| game.score_away}.compact

        goals_conceded_away_team_average = goals_conceded_away_team.sum / goals_conceded_away_team.length.to_f
        goals_scored_away_team_average = goals_scored_away_team.sum / goals_scored_away_team.length.to_f

        attacking_strength_away_team = goals_scored_away_team_average / averagehomegoals
        defensive_strength_away_team = goals_conceded_away_team_average / averageawayconceded

        projected_home_team_goals = attacking_strength_home_team * defensive_strength_away_team * averagehomegoals
        projected_away_team_goals = attacking_strength_away_team * defensive_strength_home_team * averageawaygoals

        i = 0
        home_hash = {}
        away_hash = {}

        while i <= 5 do
            away_key = "#{i}"
            home_key = "#{i}"
            away_poisson = Distribution::Poisson.pdf(i ,projected_away_team_goals)
            home_poisson = Distribution::Poisson.pdf(i ,projected_home_team_goals)
            home_hash[home_key] = home_poisson
            away_hash[away_key] = away_poisson
            i += 1
        end

        home_counter = 0
        away_counter = 0
        result_array = []

        while home_counter <= 5 do
            while away_counter <= 5 do
                result_hash = {}
                result_name = "#{home_counter} #{hometeam.name}_#{away_counter} #{awayteam.name}"
                result_hash["result name"] = result_name
                result_hash["probability"] = (home_hash["#{home_counter}"] * away_hash["#{away_counter}"])
                result_array.push(result_hash)
                away_counter += 1
            end
            home_counter += 1
            away_counter = 0
        end

        result_array.sort! {|result1, result2| result2["probability"] <=> result1["probability"] }

        overall_hash = {
            "probabilities" => result_array,
            "simple_results" => {"#{hometeam.name}" => home_hash, "#{awayteam.name}"=> away_hash},
            "average_team_strengths" => {"#{hometeam.name}" => attacking_strength_home_team + defensive_strength_home_team, "#{awayteam.name}"=> attacking_strength_away_team + defensive_strength_away_team},
            "home_team_strengths" => {"home_team_attacking_strength" => attacking_strength_home_team, "home_team_defensive_strength" => defensive_strength_home_team, "home_team_goals_scored" => home_goals_home_team, "home_team_goals_conceded" => goals_conceded_home_team},
            "away_team_strengths" => {"away_team_attacking_strength" => attacking_strength_away_team, "away_team_defensive_strength" => defensive_strength_away_team, "away_team_goals_scored" => goals_scored_away_team, "away_team_goals_conceded" => goals_conceded_away_team}  
        }

        overall_hash
    end

    def self.seed
            Game.destroy_all

            response = RestClient::Request.execute(
            method: :get,
            url: 'https://api.football-data.org/v2/competitions/2021/matches?season=2018',
            headers:{
               "X-Auth-Token": ""
            })
            response_2019 = RestClient::Request.execute(
            method: :get,
            url: 'https://api.football-data.org/v2/competitions/2021/matches?season=2019',
            headers:{
               "X-Auth-Token": ""
            })
            
            nested_hash = JSON.parse(response)
            nested_hash_2019 = JSON.parse(response_2019)
            
            nested_hash["matches"].each do |value|
                game = Game.new
                game.date = value["utcDate"]
                game.home_team = value["homeTeam"]["name"]
                game.away_team = value["awayTeam"]["name"]
                game.score_home = value["score"]["fullTime"]["homeTeam"]
                game.score_away = value["score"]["fullTime"]["awayTeam"]
                game.result = value["score"]["winner"]
                game.season = "2018"
                game.save
                hometeam = Team.find_by_name(value["homeTeam"]["name"])
                awayteam = Team.find_by_name(value["awayTeam"]["name"])
                teamgame1 = Teamgame.new
                teamgame1.game_id = game.id
                teamgame1.team_id = hometeam.id
                teamgame1.save
                teamgame2 = Teamgame.new
                teamgame2.game_id = game.id
                teamgame2.team_id = awayteam.id
                teamgame2.save
            end
            
            nested_hash_2019["matches"].each do |value|
                game = Game.new
                game.date = value["utcDate"]
                game.home_team = value["homeTeam"]["name"]
                game.away_team = value["awayTeam"]["name"]
                game.score_home = value["score"]["fullTime"]["homeTeam"]
                game.score_away = value["score"]["fullTime"]["awayTeam"]
                game.result = value["score"]["winner"]
                game.season = "2019"
                game.save
                hometeam = Team.find_by_name(value["homeTeam"]["name"])
                awayteam = Team.find_by_name(value["awayTeam"]["name"])
                teamgame1 = Teamgame.new
                teamgame1.game_id = game.id
                teamgame1.team_id = hometeam.id
                teamgame1.save
                teamgame2 = Teamgame.new
                teamgame2.game_id = game.id
                teamgame2.team_id = awayteam.id
                teamgame2.save
            end
    end

    def self.neural_network(home_team, away_team)
        home_ar = Game.where(["home_team = ?", home_team])
        home_hash = {}
        new_ar = []
        home_ar.each do |game|
            if game.result == "HOME_TEAM"
                game.result = 1
                game.home_team = 0
                game.away_team = 1
                new_ar << game
            elsif game.result == "DRAW"
                game.home_team = 0
                game.away_team = 1
                game.result = 0.5
                new_ar << game
            else
                game.home_team = 0
                game.away_team = 1
                game.result = 0
                new_ar << game
            end
        end
        input_ar = []
        output_ar = []
        new_ar.each do |game|
            row_input = []
            row_output = []
            if game.score_home == nil
            else
                row_input << game.home_team
                row_input << game.away_team
                row_output << game.result
                input_ar << row_input
                output_ar << row_output
            end
        end
        final_input_ar = input_ar.map do |ar|
                ar.map do |val|
                    val.to_f
                end
            end
        final_output_ar = output_ar.map do |ar|
                ar.map do |val|
                    val.to_f
                end    
            end
        train = RubyFann::TrainData.new(:inputs=>final_input_ar, :desired_outputs=>final_output_ar)
        fann = RubyFann::Standard.new(:num_inputs=>2, :hidden_neurons=>[1], :num_outputs=>1)
        fann.train_on_data(train, 1000, 10, 0.1)
        home_outputs = fann.run([1, 0])  

        away_ar = Game.where(["away_team = ?", away_team])
        away_hash = {} 
        new_ar = []
        away_ar.each do |game|
            if game.result == "HOME_TEAM"
                game.result = 0
                game.home_team = 0
                game.away_team = 1
                new_ar << game
            elsif game.result == "DRAW"
                game.home_team = 0
                game.away_team = 1
                game.result = 0.5
                new_ar << game
            else
                game.home_team = 0
                game.away_team = 1
                game.result = 1
                new_ar << game
            end
        end
        input_ar = []
        output_ar = []
        new_ar.each do |game|
            row_input = []
            row_output = []
            if game.score_away == nil
            else
                row_input << game.home_team
                row_input << game.away_team
                row_output << game.result
                input_ar << row_input
                output_ar << row_output
            end
        end
        final_input_ar = input_ar.map do |ar|
                ar.map do |val|
                    val.to_f
                end
            end
        final_output_ar = output_ar.map do |ar|
                ar.map do |val|
                    val.to_f
                end    
            end
        
        train = RubyFann::TrainData.new(:inputs=>final_input_ar, :desired_outputs=>final_output_ar)
        fann = RubyFann::Standard.new(:num_inputs=>2, :hidden_neurons=>[1], :num_outputs=>1)
        fann.train_on_data(train, 1000, 10, 0.1)
        away_outputs = fann.run([0, 1])  

        if 0.5 < home_outputs[0] && home_outputs[0] < 1.0
            final_home = home_outputs[0] - 0.66  
            if final_home < 0
                home_result = "DRAW"
            else
                home_result = "WIN"
            end
        else 
            final_home = home_outputs[0] - 0.33
            if final_home < 0
                home_result = "LOSS"
            else
                home_result = "DRAW"
            end
        end 

        if 0.5 < away_outputs[0] && away_outputs[0] < 1.0
            final_away = away_outputs[0] - 0.66   
            if final_away < 0
                away_result = "DRAW"    
            else
                away_result = "WIN"
            end
        else 
            final_away = away_outputs[0] - 0.33
            if final_away < 0
                away_result = "LOSS"
            else
                away_result = "DRAW"
            end
        end 

        final_home_percentage = final_home.abs() * 100 * 4
        final_away_percentage = final_away.abs() * 100 * 4

        final_hash = {}

        if final_away_percentage < final_home_percentage
            most_likely_result = "#{home_team} #{home_result}"
            confidence_percentage = final_home_percentage
        else
            most_likely_result = "#{away_team} #{away_result}"
            confidence_percentage = final_away_percentage
        end

        final_hash["result"] = most_likely_result
        final_hash["confidence"] = confidence_percentage

        final_hash
    end

    def self.k_nearest_neighbors(home_team, away_team)
        pyfrom :'sklearn.neighbors', import: :KNeighborsClassifier

        games_2019 = Game.where("season = '2019' ").where.not(result: nil)
        output_ar = []
        knn_output = []
        input_ar = games_2019.map do |game|
            poisson_hash = self.poisson(game.home_team, game.away_team)
            if game.result == "HOME_TEAM"
                result = 2
                home_team_rating = poisson_hash["average_team_strengths"]["#{game.home_team}"]
                away_team_rating = poisson_hash["average_team_strengths"]["#{game.away_team}"]
            elsif game.result == "DRAW"
                home_team_rating = poisson_hash["average_team_strengths"]["#{game.home_team}"]
                away_team_rating = poisson_hash["average_team_strengths"]["#{game.away_team}"]
                result = 1
            else
                home_team_rating = poisson_hash["average_team_strengths"]["#{game.home_team}"]
                away_team_rating = poisson_hash["average_team_strengths"]["#{game.away_team}"]
                result = 0
            end
            output_ar << [result]
            knn_output << result
            [home_team_rating, away_team_rating]
        end
        knn = KNeighborsClassifier.new(n_neighbors:9)
        knn.fit(input_ar, knn_output)
        nn_argument_team_strengths = self.poisson(home_team, away_team)
        knn_classification = knn.predict([[nn_argument_team_strengths["average_team_strengths"][home_team], nn_argument_team_strengths["average_team_strengths"][away_team]]])

        if 0.5 < home_outputs[0] && home_outputs[0] < 1.0
            final_home = home_outputs[0] - 0.66  
            if final_home < 0
                home_result = "DRAW"
            else
                home_result = "WIN"
            end
        else 
            final_home = home_outputs[0] - 0.33
            if final_home < 0
                home_result = "LOSS"
            else
                home_result = "DRAW"
            end
        end 

        if 0.5 < away_outputs[0] && away_outputs[0] < 1.0
            final_away = away_outputs[0] - 0.66   
            if final_away < 0
                away_result = "DRAW"    
            else
                away_result = "WIN"
            end
        else 
            final_away = away_outputs[0] - 0.33
            if final_away < 0
                away_result = "LOSS"
            else
                away_result = "DRAW"
            end
        end 

        final_home_percentage = final_home.abs() * 100 * 4
        final_away_percentage = final_away.abs() * 100 * 4

        final_hash = {}

        if final_away_percentage < final_home_percentage
            most_likely_result = "#{home_team} #{home_result}"
            confidence_percentage = final_home_percentage
        else
            most_likely_result = "#{away_team} #{away_result}"
            confidence_percentage = final_away_percentage
        end

        final_hash["result"] = most_likely_result
        final_hash["confidence"] = confidence_percentage

        final_hash
    end

    def self.simulate(object, params)
        # binding.pry
        homeforward1 = Player.find_by_name(params[:home_team][:f][0])
        homeforward2 = Player.find_by_name(params[:home_team][:f][1])
        homeforward3 = Player.find_by_name(params[:home_team][:f][2])
        homemidfield1 = Player.find_by_name(params[:home_team][:m][0])
        homemidfield2 = Player.find_by_name(params[:home_team][:m][1])
        homemidfield3 = Player.find_by_name(params[:home_team][:m][2])
        homedefense1 = Player.find_by_name(params[:home_team][:d][0])
        homedefense2 = Player.find_by_name(params[:home_team][:d][1])
        homedefense3 = Player.find_by_name(params[:home_team][:d][2])
        homedefense4 = Player.find_by_name(params[:home_team][:d][3])
        homekeeper1 = Player.find_by_name(params[:home_team][:g])

        awayforward1 = Player.find_by_name(params[:away_team][:f][0])
        awayforward2 = Player.find_by_name(params[:away_team][:f][1])
        awayforward3 = Player.find_by_name(params[:away_team][:f][2])
        awaymidfield1 = Player.find_by_name(params[:away_team][:m][0])
        awaymidfield2 = Player.find_by_name(params[:away_team][:m][1])
        awaymidfield3 = Player.find_by_name(params[:away_team][:m][2])
        awaydefense1 = Player.find_by_name(params[:away_team][:d][0])
        awaydefense2 = Player.find_by_name(params[:away_team][:d][1])
        awaydefense3 = Player.find_by_name(params[:away_team][:d][2])
        awaydefense4 = Player.find_by_name(params[:away_team][:d][3])
        awaykeeper1 = Player.find_by_name(params[:away_team][:g])


        offensive_contribution_homeforward1 = (homeforward1.goals_per_game * 12) / object["home_team_strengths"]["home_team_goals_scored"].sum
        offensive_contribution_homeforward2 = (homeforward2.goals_per_game * 12) / object["home_team_strengths"]["home_team_goals_scored"].sum
        offensive_contribution_homeforward3 = (homeforward3.goals_per_game * 12) / object["home_team_strengths"]["home_team_goals_scored"].sum

        offensive_contribution_awayforward1 = (awayforward1.goals_per_game * 12) / object["away_team_strengths"]["away_team_goals_scored"].sum
        offensive_contribution_awayforward2 = (awayforward2.goals_per_game * 12) / object["away_team_strengths"]["away_team_goals_scored"].sum
        offensive_contribution_awayforward3 = (awayforward3.goals_per_game * 12) / object["away_team_strengths"]["away_team_goals_scored"].sum

        overall_contribution_homeforward1 = offensive_contribution_homeforward1 * object["home_team_strengths"]["home_team_attacking_strength"]
        overall_contribution_homeforward2 = offensive_contribution_homeforward2 * object["home_team_strengths"]["home_team_attacking_strength"]
        overall_contribution_homeforward3 = offensive_contribution_homeforward3 * object["home_team_strengths"]["home_team_attacking_strength"]

        overall_contribution_awayforward1 = offensive_contribution_awayforward1 * object["away_team_strengths"]["away_team_attacking_strength"]
        overall_contribution_awayforward2 = offensive_contribution_awayforward2 * object["away_team_strengths"]["away_team_attacking_strength"]
        overall_contribution_awayforward3 = offensive_contribution_awayforward3 * object["away_team_strengths"]["away_team_attacking_strength"]

        home_team_offensive_power_forwards = overall_contribution_homeforward1 + overall_contribution_homeforward2 + overall_contribution_homeforward3
        away_team_offensive_power_forwards = overall_contribution_awayforward1 + overall_contribution_awayforward2 + overall_contribution_awayforward3

        if home_team_offensive_power_forwards > away_team_offensive_power_forwards
            return "Liverpool FC Win"
        elsif home_team_offensive_power_forwards == away_team_offensive_power_forwards
            return "Draw"
        else
            return "Tottenham Hotspur FC Win"
        end
        # defensive_contribution_homedefense1 = (homedefense1.conceded_per_game * 12) / object["home_team_strengths"]["home_team_goals_conceded"].sum
        # defensive_contribution_homedefense2 = (homedefense2.conceded_per_game * 12) / object["home_team_strengths"]["home_team_goals_conceded"].sum
        # defensive_contribution_homedefense3 = (homedefense3.conceded_per_game * 12) / object["home_team_strengths"]["home_team_goals_conceded"].sum
        # defensive_contribution_homedefense4 = (homedefense4.conceded_per_game * 12) / object["home_team_strengths"]["home_team_goals_conceded"].sum

        # defensive_contribution_awaydefense1 = (awaydefense1.conceded_per_game * 12) / object["away_team_strengths"]["away_team_goals_conceded"].sum
        # defensive_contribution_awaydefense2 = (awaydefense2.conceded_per_game * 12) / object["away_team_strengths"]["away_team_goals_conceded"].sum
        # defensive_contribution_awaydefense3 = (awaydefense3.conceded_per_game * 12) / object["away_team_strengths"]["away_team_goals_conceded"].sum
        # defensive_contribution_awaydefense4 = (awaydefense4.conceded_per_game * 12) / object["away_team_strengths"]["away_team_goals_conceded"].sum

        # overall_contribution_homedefense1 = ( 1 - defensive_contribution_homedefense1 ) * object["home_team_strengths"]["home_team_defensive_strength"]
        # overall_contribution_homedefense2 = ( 1 - defensive_contribution_homedefense2 ) * object["home_team_strengths"]["home_team_defensive_strength"]
        # overall_contribution_homedefense3 = ( 1 - defensive_contribution_homedefense3 ) * object["home_team_strengths"]["home_team_defensive_strength"]
        # overall_contribution_homedefense4 = ( 1 - defensive_contribution_homedefense4 ) * object["home_team_strengths"]["home_team_defensive_strength"]

        # overall_contribution_awaydefense1 = ( 1 - defensive_contribution_awaydefense1) * object["away_team_strengths"]["away_team_defensive_strength"]
        # overall_contribution_awaydefense2 = ( 1 - defensive_contribution_awaydefense2) * object["away_team_strengths"]["away_team_defensive_strength"]
        # overall_contribution_awaydefense3 = ( 1 - defensive_contribution_awaydefense3) * object["away_team_strengths"]["away_team_defensive_strength"]
        # overall_contribution_awaydefense4 = ( 1 - defensive_contribution_awaydefense4) * object["away_team_strengths"]["away_team_defensive_strength"]

        # home_team_defensive_power_defense = overall_contribution_homedefense1 + overall_contribution_homedefense2 + overall_contribution_homedefense3 + overall_contribution_homedefense4
        # away_team_defensive_power_defense = overall_contribution_awaydefense1 + overall_contribution_awaydefense2 + overall_contribution_awaydefense3 + overall_contribution_awaydefense4

        # home_team_defensive_power_goalkeeping = (homekeeper1.save_percentage / 100.0) * object["home_team_strengths"]["home_team_defensive_strength"]
        # away_team_defensive_power_goalkeeping = (awaykeeper1.save_percentage / 100.0) * object["away_team_strengths"]["away_team_defensive_strength"]

        binding.pry
        # overall_hash = {
        #     "probabilities" => result_array,
        #     "simple_results" => {"#{hometeam.name}" => home_hash, "#{awayteam.name}"=> away_hash},
        #     "average_team_strengths" => {"#{hometeam.name}" => attacking_strength_home_team + defensive_strength_home_team, "#{awayteam.name}"=> attacking_strength_away_team + defensive_strength_away_team},
        #     "home_team_strengths" => {"home_team_attacking_strength" => attacking_strength_home_team, "home_team_attacking_strength" => defensive_strength_home_team, "home_team_goals_scored" => home_goals, "home_team_goals_conceded" => goals_conceded_home_team},
        #     "away_team_strengths" => {"away_team_attacking_strength" => attacking_strength_away_team, "away_team_attacking_strength" => defensive_strength_away_team, "away_team_goals_scored" => away_goals, "away_team_goals_conceded" => goals_conceded_away_team}  
        # }
    end
end
