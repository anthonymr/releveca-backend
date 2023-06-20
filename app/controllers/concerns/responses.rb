module Responses
  extend ActiveSupport::Concern

  def forbidden(message = 'Not authorized')
    render json: { errors: [message] }, status: :unauthorized
  end

  def bad_request
    render json: { errors: ['Bad request'] }, status: :bad_request
  end

  def unprocessable_entity(item)
    render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
  end

  def not_authenticated
    render json: { errors: ['Not authenticated'] }, status: :unauthorized
  end

  def not_found(item)
    render json: { errors: ["#{item} not found"] }, status: :not_found
  end

  def invalid_login(message)
    render json: { errors: [message || 'Invalid username or password'] }, status: :unauthorized
  end

  def created(json, message)
    render json: { payload: json, message: message || 'Created' }, status: :created
  end

  def accepted(json, message)
    render json: { payload: json, message: message || 'Acepted' }, status: :accepted
  end

  def head_no_content(message)
    head :no_content
    render message:, status: :ok
  end

  def ok(json, message = nil)
    render json: { payload: json, message: message || 'OK' }, status: :ok
  end
end
