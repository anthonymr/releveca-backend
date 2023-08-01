module Responses
  extend ActiveSupport::Concern

  def unauthorized(message = 'Not authorized')
    render json: { errors: [message] }, status: :unauthorized
  end

  def bad_request(message = 'Bad request')
    render json: { errors: [message] }, status: :bad_request
  end

  def unprocessable_entity(entity)
    render json: { errors: entity.errors.full_messages }, status: :unprocessable_entity
  end

  def not_found(entity_name = 'Entity')
    render json: { errors: ["#{entity_name} not found"] }, status: :not_found
  end

  def invalid_login(message = 'Invalid username or password')
    render json: { errors: [message] }, status: :unauthorized
  end

  def created(json, message = 'Created')
    render json: { payload: json, message: }, status: :created
  end

  def accepted(json, message = 'Acepted')
    render json: { payload: json, message: }, status: :accepted
  end

  def head_no_content(message = 'Head no content')
    head :no_content
    render message:, status: :ok
  end

  def ok(json, message = 'OK')
    render json: { payload: json, message: }, status: :ok
  end
end
