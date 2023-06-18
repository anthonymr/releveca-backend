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

  def corporations
    ok(Current.user.corporations, 'Corporations retrieved successfully')
  end

  def add_corporation
    corporation = Corporation.find(params[:id])
    return forbidden if Current.user.corporations.include?(corporation)

    Current.user.corporations << corporation
    ok(Current.user.no_password, 'Corporation added successfully')
  rescue ActiveRecord::RecordNotFound
    not_found('Corporation')
  end

  private

  def user_params
    params.permit(:name, :last_name, :user_name, :email, :password)
  end
end
