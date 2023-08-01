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

  def simulate_login
    user = User.create(name: 'example user', last_name: 'test', user_name: 'username', password: 'password', email: 'example@mail.com')
    user.update(status: 'enabled')
    params = { user_name: 'username', password: 'password' }
    post(auth_path, params:)
    JSON.parse(response.body)['payload']['token']
  end
end
