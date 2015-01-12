FactoryGirl.define do
  factory :cart_item do
    cart
    game
    amount 2
    price 1.5
  end

end
