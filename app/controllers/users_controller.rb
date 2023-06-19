class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def index
    ok(User.all_no_password, 'Users retrieved successfully')
  end

  def show
    ok(Current.user.no_password, 'User retrieved successfully')
  end

  def create
    user = User.new(user_params)
    user.save ? created(user.no_password, 'User created') : unprocessable_entity(user)
  end

  def update
    return unprocessable_entity(Current.user) unless Current.user.update(user_params)

    accepted(Current.user.no_password, 'User updated')
  end

  def change_status
    user = User.find(params[:id])
    user.update(status: params[:status]) ? accepted(user.no_password, 'User updated') : unprocessable_entity(user)
  rescue ActiveRecord::RecordNotFound
    not_found('User')
  end

  def corporations
    ok(Current.user.corporations, 'Corporations retrieved successfully')
  end

  def add_corporation
    corporation = Corporation.find(params[:id])
    return forbidden unless corporation&.enabled?
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
