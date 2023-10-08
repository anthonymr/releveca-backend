# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

# create test currency
if Currency.count.zero?
  Currency.create(
    code: 'USD',
    description: 'United States Dollar',
    rate: 1
  )
end

# create test corporation
if Corporation.count.zero?
  Corporation.create(
    name: 'Default Corporation',
    rif: 'J50000000',
    address: 'Default Address',
    phone: '0000000000',
    email: 'corp@testing.com',
    website: 'www.testing.com',
    status: 'enabled',
    default_currency_id: Currency.first.id,
    base_currency_id: Currency.first.id
  )
end

# create test admin user
if User.count.zero?
  User.create(
    name: 'Admin',
    last_name: 'Admin',
    user_name: 'admin',
    email: 'test@testing.com',
    password: 'password1',
    status: 'enabled',
  )
end

# create test items
if Item.count.zero?
  100.times do |i|
    Item.create(
      code: "CODE#{i}",
      name: Faker::Commerce.product_name,
      model: "Model #{i}",
      stock: 100,
      unit: 'UND',
      price: Faker::Commerce.price,
      corporation_id: Corporation.first.id,
      status: 'enabled'
    )
  end
end

# create test country
Country.create(name: 'VENEZUELA') if Country.count.zero?


# create test clients
if Client.count.zero?
  100.times do |i|
    Client.create(
      code: "CODE#{i}",
      client_type: 1,
      name: Faker::Company.name,
      phone: Faker::PhoneNumber.cell_phone,
      status: 'enabled',
      notes: Faker::Lorem.paragraph,
      address: Faker::Address.full_address,
      rif: "J#{Faker::Number.number(digits: 8)}",
      taxpayer: true,
      nit: Faker::Number.number(digits: 8),
      email: Faker::Internet.email,
      index: i,
      corporation_id: Corporation.first.id,
      user_id: User.first.id,
      country_id: Country.first.id,
      approval: true
    )
  end
end