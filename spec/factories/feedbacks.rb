FactoryGirl.define do
  factory :feedback do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    message { Faker::Lorem.characters(1200) }
  end
end
