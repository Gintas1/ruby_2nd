FactoryGirl.define do
  factory :comment do
    game
    user
    content 'MyText'
  end

end
