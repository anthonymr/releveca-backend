class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    user = User.find_by(user_name: params[:user_name])
    return invalid_login('Usuario o contraseña inválidos') unless user&.authenticate(params[:password])
    return invalid_login('Usuario deshabilitado, contacte a un administrador') unless user.enable?

    token = JwtService.encode({ user_id: user.id })
    ok({ token: }, 'Logged in')
  end

  def destroy
    return unauthorized('Not authenticated') unless Current.user

    Current.corporation = nil
    Current.user = nil
    ok(nil, 'Logged out')
  end

  def show
    Current.user ? ok(Current.user) : unauthorized('Not authenticated')
  end
end
