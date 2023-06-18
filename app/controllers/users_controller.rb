class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def index
    render json: User.all_no_password, status: :ok
  end

  def create
    user = User.new(user_params)
    user.save ? created(user.no_password) : unprocessable_entity(user)
  end

  def update
    Current.user.update(user_params) ? accepted(Current.user.no_password) : unprocessable_entity(Current.user)
  end

  def destroy
    Current.user.destroy ? head_no_content('User deleted') : unprocessable_entity(Current.user)
  end

  private

  def user_params
    params.permit(:name, :last_name, :user_name, :email, :password)
  end
end
