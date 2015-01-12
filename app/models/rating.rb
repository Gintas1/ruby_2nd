# class for rating a game
class Rating < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
end
