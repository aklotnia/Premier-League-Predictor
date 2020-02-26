class LiveGamesController < ApplicationController

    def index
        livegames = LiveGame.all
        render json: livegames
    end

end
