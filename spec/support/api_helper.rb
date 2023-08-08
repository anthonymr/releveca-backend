require 'jwt'

module ApiHelpers
  def json
    JSON.parse(response.body)
  end

  def new_user_params
    {
      name: "#{Faker::Name.first_name}test",
      last_name: Faker::Name.last_name,
      user_name: Faker::Internet.username,
      email: Faker::Internet.email,
      password: Faker::Internet.password
    }
  end

  def new_corporation_params(currency)
    {
      name: Faker::Company.name,
      rif: "J#{Faker::Number.number(digits: 9)}",
      address: Faker::Address.full_address,
      phone: Faker::Number.number(digits: 9),
      email: Faker::Internet.email,
      base_currency_id: currency.id,
      default_currency_id: currency.id
    }
  end

  def simulate_login
    @user = User.create(name: 'example user', last_name: 'test', user_name: 'username', password: 'password', email: 'example@mail.com')
    @user.update(status: 'enabled')
    params = { user_name: 'username', password: 'password' }
    post(auth_path, params:)
    JSON.parse(response.body)['payload']['token']
  end

  def select_corporation(token)
    corporation = FactoryBot.create(:corporation)
    @user.corporations << corporation
    post(select_corporation_path, as: :json, headers: { Authorization: token }, params: { id: corporation.id })
    corporation
  end
end
