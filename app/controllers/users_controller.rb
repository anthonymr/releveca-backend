class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: :create
  before_action :check_user, except: :create

  rescue_from(ActiveRecord::RecordNotFound) { |e| not_found(e.message) }

  def index
    ok(User.all.no_password, 'Users retrieved successfully')
  end

  def show
    ok(user&.no_password, 'User retrieved successfully')
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
    if new_user.save
      created(new_user.no_password, 'User created')
    else
      unprocessable_entity(new_user)
    end
  end

  def update
    if Current.user.update(user_params)
      ok(Current.user.no_password, 'User updated')
    else
      unprocessable_entity(Current.user)
    end
  end

  def change_status
    if user.update(status: params[:status])
      ok(user.no_password, 'User updated')
    else
      unprocessable_entity(user)
    end
  end

  def corporations
    return unless check_corporation

    ok(Current.user.corporations, 'Corporations retrieved successfully')
  end

  def add_corporation
    return unauthorized unless corporation&.enabled?
    return unauthorized if corporation&.mine?

    Current.user.corporations << corporation
    ok(corporation, 'Corporation added successfully')
  end

  private

  def corporation
    @corporation ||= Corporation.find(params[:id])
  end

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.permit(:name, :last_name, :user_name, :email, :password)
  end
end
