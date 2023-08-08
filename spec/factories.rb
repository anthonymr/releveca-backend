FactoryBot.define do
  factory :user do
    name { "#{Faker::Name.first_name}_test" }
    last_name { Faker::Name.last_name }
    user_name { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
