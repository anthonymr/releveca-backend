class ApplicationController < ActionController::API
  include JwtToken
  include Authenticable
  include HttpResponses
  include Validations
end
