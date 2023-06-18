module Authenticable
  private

  def authenticate_user
    header = request.headers['Authorization']&.split&.last
    begin
      decoded = jwt_decode(header)
      Current.user = User.find(decoded[:user_id])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end