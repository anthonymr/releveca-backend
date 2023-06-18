module Responses
  def forbidden
    render json: { errors: ['Not authorized'] }, status: :unauthorized
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

  def invalid_login
    render json: { errors: ['Invalid username or password'] }, status: :unauthorized
  end

  def created(json)
    render json:, status: :created
  end

  def accepted(json)
    render json:, status: :accepted
  end

  def head_no_content(message)
    head :no_content
    render json: { message: }, status: :ok
  end

  def ok(json, message)
    if json.present?
      render json:, status: :ok
    elsif message.present?
      render json: { message: }, status: :ok
    else
      render json: { message: 'OK' }, status: :ok
    end
  end
end
