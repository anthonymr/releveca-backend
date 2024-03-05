class CategoriesController < ApplicationController
    skip_before_action :authenticate_user, only: %i[public_categories public_home_categories]
    before_action :check_user, except: %i[public_categories public_home_categories]
    before_action :check_corporation, except: %i[public_categories public_home_categories]
  
    rescue_from(ActiveRecord::RecordNotFound) { |e| not_found(e.message) }
    rescue_from(ActiveRecord::RecordNotUnique) { |e| not_unique }
  
    
    def public_categories
    #   items = Item.all.as_json(only: %i[code name model stock unit show_in_web_home_tags])
    #   ok({ items: items }, 'Public items retrieved successfully')
        categories = Category.all.as_json(only: %i[name description color])
        ok({ categories: categories }, 'Public categories retrieved successfully')
    end
  
    def public_home_categories
        categories = Category.where(show_in_web_home: true).as_json(only: %i[name description color])
        ok({ categories: categories }, 'Public home categories retrieved successfully')
    end
  end
  