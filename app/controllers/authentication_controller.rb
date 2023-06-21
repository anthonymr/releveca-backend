class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    user = User.find_by(user_name: params[:user_name])
    return invalid_login('User disabled') unless user.enable?
    return invalid_login unless user&.authenticate(params[:password])

    token = jwt_encode({ user_id: user.id })
    ok({ token: }, 'Logged in')
  end

  def destroy
    return not_authenticated unless Current.user

    Current.user.update(current_corporation: nil)
    Current.user = nil

    ok(nil, 'Logged out')
  end

  def show
    Current.user ? ok(Current.user, nil) : not_authenticated
  end
end
