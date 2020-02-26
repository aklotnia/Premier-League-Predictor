class PlayersController < ApplicationController

    def liverpool
        players = Team.find_by_name("Liverpool FC").players
        sorted = players.sort_by {|obj| obj.position}
        render json: players
    end

    def tottenham
        players = Team.find_by_name("Tottenham Hotspur FC").players
        sorted = players.sort_by {|obj| obj.position}
        render json: players
    end

end
