class WarrantiesController < ApplicationController
    def index
        clients = params[:clients].split(',') if params[:clients]
        items = params[:items].split(',') if params[:items]
        from = params[:from] if params[:from]
        to = params[:to] if params[:to]

        if !from.present? && !to.present?
            if params[:filter] == "today"
                warranties = Warranty.mine.includes(:client, :item, :user, :corporation).where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).all
            elsif params[:filter] == "yesterday"
                warranties = Warranty.mine.includes(:client, :item, :user, :corporation).where(created_at: Time.zone.now.yesterday.beginning_of_day..Time.zone.now.yesterday.end_of_day).all
            elsif params[:filter] == "week"
                warranties = Warranty.mine.includes(:client, :item, :user, :corporation).where(created_at: Time.zone.now.beginning_of_week..Time.zone.now.end_of_week).all
            elsif params[:filter] == "lastWeek"
                warranties = Warranty.mine.includes(:client, :item, :user, :corporation).where(created_at: Time.zone.now.last_week.beginning_of_week..Time.zone.now.last_week.end_of_week).all
            elsif params[:filter] == "month"
                warranties = Warranty.mine.includes(:client, :item, :user, :corporation).where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).all
            elsif params[:filter] == "lastMonth"
                warranties = Warranty.mine.includes(:client, :item, :user, :corporation).where(created_at: Time.zone.now.last_month.beginning_of_month..Time.zone.now.last_month.end_of_month).all
            elsif params[:filter] == "year"
                warranties = Warranty.mine.includes(:client, :item, :user, :corporation).where(created_at: Time.zone.now.beginning_of_year..Time.zone.now.end_of_year).all
            else
                warranties = Warranty.mine.includes(:client, :item, :user, :corporation).all
            end
        else
            from = Date.parse(from)
            to = Date.parse(to)
            warranties = Warranty.mine.includes(:client, :item, :user, :corporation).where(created_at: from.beginning_of_day..to.end_of_day).all
        end

        if clients.present? && clients.any?
            clients = clients.map(&:to_i)
            warranties = warranties.where(client_id: clients).all
        end

        if items.present? && items.any?
            items = items.map(&:to_i)
            warranties = warranties.where(item_id: items).all
        end

        if params[:global_filter].present? && params[:global_filter_field].present?
            global_filter = params[:global_filter].downcase
            global_filter_field = params[:global_filter_field]

            if global_filter_field == "client_name"
                warranties = warranties.joins(:client).where("LOWER(clients.name) LIKE ?", "%#{global_filter}%").all
            elsif global_filter_field == "item_code"
                warranties = warranties.joins(:item).where("LOWER(items.code) LIKE ?", "%#{global_filter}%").all
            elsif global_filter_field == "item_name"
                warranties = warranties.joins(:item).where("LOWER(items.name) LIKE ?", "%#{global_filter}%").all
            elsif global_filter_field == "notes"
                warranties = warranties.where("LOWER(notes) LIKE ?", "%#{global_filter}%").all
            elsif global_filter_field == "status"
                warranties = warranties.where("LOWER(status) LIKE ?", "%#{global_filter}%").all
            end
        end
        warranties_json = warranties.as_json(
            include: {
                client: { only: [:id, :name] },
                item: { only: [:id, :name, :code] },
                user: { only: [:id, :name] },
                corporation: { only: [:id, :name] }
            }
        )

        ok(warranties_json, 'Warranties retrieved successfully')
    end

    def show
        ok(warranty, 'Warranty retrieved successfully')
    end

    def create
        new_warranty = Warranty.new(warranty_params)

        new_warranty.user_id = Current.user.id
        new_warranty.corporation_id = Current.corporation.id

        if new_warranty.save
            ok(new_warranty, 'Warranty created')
        else
            bad_request(new_warranty.errors)
        end
    end

    def update
        if warranty.update(warranty_params)
            ok(warranty, 'Warranty updated')
        else
            bad_request(warranty.errors)
        end
    end

    def destroy
        ok(warranty, 'Warranty deleted') if warranty.destroy
    end

    def grouped_by_item
        warranties = Warranty.mine.includes(:client, :item, :user, :corporation).all

        warranties_json = warranties.as_json(
            include: {
                client: { only: [:id, :name] },
                item: { only: [:id, :name, :code] },
                user: { only: [:id, :name] },
                corporation: { only: [:id, :name] }
            }
        )

        grouped_warranties = warranties_json.group_by { |warranty| warranty['item']['name'] }

        ok(grouped_warranties, 'Warranties retrieved successfully')
    end

    def grouped_by_client
        warranties = Warranty.mine.includes(:client, :item, :user, :corporation).all

        warranties_json = warranties.as_json(
            include: {
                client: { only: [:id, :name] },
                item: { only: [:id, :name, :code] },
                user: { only: [:id, :name] },
                corporation: { only: [:id, :name] }
            }
        )

        grouped_warranties = warranties_json.group_by { |warranty| warranty['client']['name'] }
        
        ok(grouped_warranties, 'Warranties retrieved successfully')
    end
        

    private

    def warranty_params
        params.permit(:quantity, :notes, :status, :client_id, :item_id, :user_id, :corporation_id)
    end

    def warranty
        @warranty ||= Warranty.find(params[:id])
    end
end