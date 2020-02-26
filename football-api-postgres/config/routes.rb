Rails.application.routes.draw do
  get '/games', to: "games#index"
  post '/games/simulate', to: "games#simulate"
  get '/games/:teamname', to: "games#filter"
  get '/games/:hometeam/:awayteam', to: "games#poisson"
  get '/games/nn/:hometeam/:awayteam', to: "games#neural_network"

  get '/teams', to: "teams#index"
  get '/teams/:teamname', to: "teams#show"

  get '/standings', to: "standings#index"

  get '/live', to: "live_games#index"

  get '/players/liverpool', to: "players#liverpool"
  get '/players/tottenham', to: "players#tottenham"
end
