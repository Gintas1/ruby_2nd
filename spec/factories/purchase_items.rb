FactoryGirl.define do
  factory :purchase_item do
    purchase
    game
    amount 2
    price 1.5
  end

end
