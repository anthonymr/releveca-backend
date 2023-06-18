class ApplicationController < ActionController::API
  include JwtToken
  include Authenticable
  include Responses

  before_action :authenticate_user
end
