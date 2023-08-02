class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def index
    ok(User.all_no_password, 'Users retrieved successfully')
  end

  def show
    user = User.find(params['id'])
    ok(user.no_password, 'User retrieved successfully')
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def current
    if Current.user
      ok(Current.user.no_password, 'User retrieved successfully')
    else
      unauthorized
    end
  end

  def create
    new_user = User.new(user_params)
    new_user.save ? created(new_user.no_password, 'User created') : unprocessable_entity(new_user)
  end

  def update
    return ok(Current.user.no_password, 'User updated') if Current.user.update(user_params)

    unprocessable_entity(Current.user)
  end

  def change_status
    user = User.find(params[:id])
    user.update(status: params[:status]) ? ok(user.no_password, 'User updated') : unprocessable_entity(user)
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def corporations
    ok(Current.user.corporations, 'Corporations retrieved successfully')
  end

  def add_corporation
    corporation = Corporation.find(params[:id])
    return unauthorized unless corporation&.enabled?
    return unauthorized if Current.user.corporations.include?(corporation)

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
