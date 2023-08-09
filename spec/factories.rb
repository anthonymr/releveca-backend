FactoryBot.define do
  factory :user do
    name { "#{Faker::Name.first_name}_test" }
    last_name { Faker::Name.last_name }
    user_name { "#{Faker::Internet.username}_test" }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :currency do
    code { Faker::Code.sin }
    description { Faker::Name.first_name }
    rate { 1 }
  end

  factory :corporation do
    name { "#{Faker::Name.first_name}_test" }
    rif { "J#{Faker::Number.number(digits: 9)}" }
    address { Faker::Address.full_address }
    phone { Faker::PhoneNumber.cell_phone }
    email { Faker::Internet.email }
    default_currency { FactoryBot.create(:currency) }
    base_currency { FactoryBot.create(:currency) }
  end

  factory :item do
    code { Faker::Code.unique.sin }
    name { Faker::Code.unique.sin }
    model { Faker::Name.last_name }
    stock { Faker::Number.number(digits: 3) }
    unit { Faker::Number.number(digits: 2) }
    price { Faker::Number.decimal(l_digits: 2) }
    index { Faker::Number.number(digits: 2) }
    corporation { FactoryBot.create(:corporation) }
  end
end
