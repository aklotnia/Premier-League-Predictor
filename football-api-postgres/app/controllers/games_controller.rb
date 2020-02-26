class GamesController < ApplicationController
    def index    
        games = Game.where(result: nil)
        render json: games
    end

    def filter
        games = Game.where(home_team: params[:teamname], result: nil).or(Game.where(away_team: params[:teamname], result: nil))
        render json: games
    end

    def poisson
        predictions = Game.poisson(params[:hometeam], params[:awayteam])
        render json: predictions
    end

    def neural_network
        predictions = Game.neural_network(params[:hometeam], params[:awayteam])
        render json: predictions
    end

    def simulate
        result_hash = Game.poisson("Liverpool FC", "Tottenham Hotspur FC")
        result = Game.simulate(result_hash, params[:state])
        render json: [result]
    end
end
