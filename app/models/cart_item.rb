# class for cart items
class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :game
end
