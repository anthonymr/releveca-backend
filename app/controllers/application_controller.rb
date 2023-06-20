class ApplicationController < ActionController::API
  include JwtToken
  include Authenticable
  include Responses
  include Validations

  before_action :authenticate_user
end
