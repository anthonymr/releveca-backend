class Warranty < ApplicationRecord
    belongs_to :corporation
    belongs_to :client
    belongs_to :user
    belongs_to :item
    belongs_to :supplier
    belongs_to :seller

    has_many_attached :files

    def files_count
        files.count
    end

    def files_urls
        files.map do |file|
            blob = Rails.application.routes.url_helpers.rails_blob_path(file, only_path: true)
            Rails.application.routes.url_helpers.url_for(blob)
        end
    end
    # def as_json_with_image(image_url, full_data: true)
    #     return as_json unless image.attached?
    #     return as_json.merge(image_url:) if full_data
    
    #     as_json(only: %i[id name description]).merge(image_url:)
    #   end

    # render json: new_room.as_json_with_image(url_for(new_room.image)), status: 201

    def mine?
        corporation == Current.corporation
    end

    def self.mine
        Current.corporation.warranties
    end
end
