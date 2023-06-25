class Settings::ModulesController < ApplicationController
  def index
    ok(Setting.modules, 'Modules retrieved successfully')
  end
end
