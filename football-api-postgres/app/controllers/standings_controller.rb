class StandingsController < ApplicationController
    def index
        standings = Standing.all
        render json: standings
    end
end
