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
    name { "#{Faker::Name.unique.first_name}_test" }
    rif { "J#{Faker::Number.unique.number(digits: 9)}" }
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

  factory :country do
    name { Faker::Alphanumeric.unique.alpha(number: 10).upcase }
  end

  factory :client do
    code { Faker::Code.unique.sin }
    name { Faker::Name.unique.name }
    rif { "J#{Faker::Number.unique.number(digits: 9)}" }
    client_type { 1 }
    phone { Faker::PhoneNumber.cell_phone }
    notes { Faker::Lorem.sentence }
    address { Faker::Address.full_address }
    taxpayer { true }
    email { Faker::Internet.email }
    index { Faker::Number.number(digits: 2) }
    corporation { FactoryBot.create(:corporation) }
    user { FactoryBot.create(:user) }
    country { FactoryBot.create(:country) }
  end

  factory :payment_condition do
    code { Faker::Code.unique.sin }
    description { Faker::Name.unique.name }
    days { Faker::Number.number(digits: 2) }
    index { Faker::Number.number(digits: 4) }
    corporation { FactoryBot.create(:corporation) }
  end

  factory :order do
    client { FactoryBot.create(:client) }
    user { FactoryBot.create(:user) }
    currency { FactoryBot.create(:currency) }
    payment_condition { FactoryBot.create(:payment_condition) }
    corporation { FactoryBot.create(:corporation) }
    status { 'creado' }
    sub_total { Faker::Number.decimal(l_digits: 2) }
    total { sub_total }
    balance { sub_total }
    rate { Faker::Number.decimal(l_digits: 2) }
    taxes { 0 }

    factory :order_with_details do
      transient do
        order_details_count { 5 }
      end

      after(:create) do |order, evaluator|
        create_list(:order_detail, evaluator.order_details_count, order:)
      end
    end
  end

  factory :order_detail do
    item { FactoryBot.create(:item) }
    qty { Faker::Number.number(digits: 2) }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    total_price { Faker::Number.decimal(l_digits: 2) }
    order { FactoryBot.create(:order) }
    currency { FactoryBot.create(:currency) }
  end
end
