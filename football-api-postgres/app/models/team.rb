class Team < ApplicationRecord
    has_many :teamgames
    has_many :games, through: :teamgames
    has_many :players
end