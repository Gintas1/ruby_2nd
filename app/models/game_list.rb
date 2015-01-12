# class for game
class GameList < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
end
