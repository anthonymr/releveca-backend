module Validations
  extend ActiveSupport::Concern

  private

  def check_corporation
    return forbidden('First select a corporation') unless Current.corporation
  end

  def check_user
    return forbidden('First login') unless Current.user
  end
end
