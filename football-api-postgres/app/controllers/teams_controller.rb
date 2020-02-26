class TeamsController < ApplicationController
    def index
        teams = Team.all
        render json: teams
    end

    def show
        desired_team = Team.find_by_name(params[:teamname])
        render json: desired_team
    end
end
