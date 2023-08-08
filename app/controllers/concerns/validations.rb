module Validations
  extend ActiveSupport::Concern

  private

  def check_corporation
    return true if Current.corporation

    unauthorized('First select a corporation')
    false
  end

  def check_user
    return true if Current.user

    unauthorized('First login')
    false
  end
end
