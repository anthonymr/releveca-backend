class ApplicationController < ActionController::API
  include JwtToken
  include Authenticable
  include HTTPResponses
  include Validations

  before_action :authenticate_user
end
