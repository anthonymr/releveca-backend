class ApplicationController < ActionController::API
  include Authenticable
  include HttpResponses
  include Validations
end
