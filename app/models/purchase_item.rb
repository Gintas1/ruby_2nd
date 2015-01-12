# class for purchased item
class PurchaseItem < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :game
end
