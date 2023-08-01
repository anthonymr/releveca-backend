class ApplicationController < ActionController::API
  include JwtToken
  include Authenticable
  include HttpResponses
  include Validations

  before_action :authenticate_user
end
