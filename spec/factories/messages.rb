FactoryGirl.define do
  factory :message do
    association :sender, factory: :user
    association :recipient, factory: :mike
    content 'MyText'
    topic 'MyString'
  end

end
