FactoryGirl.define do
  factory :user do
    username 'MyString'
    password 'MyString'
    password_confirmation 'MyString'
    email 'MyString@example.com'
    balance 1000
    blocked false
    admin false
    factory :admin do
      admin true
    end
    factory :blocked do
      blocked true
    end
    factory :mike do
      username 'mike'
      email 'mike@example.com'
    end

  end

end
