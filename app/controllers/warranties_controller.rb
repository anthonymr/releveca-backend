class WarrantiesController < ApplicationController
    include ActiveStorage::SetCurrent
    
    def index
        clients = params[:clients].split(',') if params[:clients]
        items = params[:items].split(',') if params[:items]
        from = params[:from] if params[:from]
        to = params[:to] if params[:to]

        warranties = Warranty.mine.includes(:client, :item, :user, :corporation, :supplier, :seller).with_attached_files

        if !from.present? && !to.present?
            if params[:filter] == "today"
                if params[:include_updated_at]
                    warranties = warranties.where("(created_at >= ? AND created_at <= ?) OR (updated_at >= ? AND updated_at <= ?)", Time.zone.now.beginning_of_day, Time.zone.now.end_of_day, Time.zone.now.beginning_of_day, Time.zone.now.end_of_day).all
                else
                    warranties = warranties.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).all
                end
            elsif params[:filter] == "yesterday"
                if params[:include_updated_at]
                    warranties = warranties.where("(created_at >= ? AND created_at <= ?) OR (updated_at >= ? AND updated_at <= ?)", Time.zone.now.yesterday.beginning_of_day, Time.zone.now.yesterday.end_of_day, Time.zone.now.yesterday.beginning_of_day, Time.zone.now.yesterday.end_of_day).all
                else
                    warranties = warranties.where(created_at: Time.zone.now.yesterday.beginning_of_day..Time.zone.now.yesterday.end_of_day).all
                end
            elsif params[:filter] == "week"
                if params[:include_updated_at]
                    warranties = warranties.where("(created_at >= ? AND created_at <= ?) OR (updated_at >= ? AND updated_at <= ?)", Time.zone.now.beginning_of_week, Time.zone.now.end_of_week, Time.zone.now.beginning_of_week, Time.zone.now.end_of_week).all
                else
                    warranties = warranties.where(created_at: Time.zone.now.beginning_of_week..Time.zone.now.end_of_week).all
                end
            elsif params[:filter] == "lastWeek"
                if params[:include_updated_at]
                    warranties = warranties.where("(created_at >= ? AND created_at <= ?) OR (updated_at >= ? AND updated_at <= ?)", Time.zone.now.last_week.beginning_of_week, Time.zone.now.last_week.end_of_week, Time.zone.now.last_week.beginning_of_week, Time.zone.now.last_week.end_of_week).all
                else
                    warranties = warranties.where(created_at: Time.zone.now.last_week.beginning_of_week..Time.zone.now.last_week.end_of_week).all
                end
            elsif params[:filter] == "month"
                if params[:include_updated_at]
                    warranties = warranties.where("(created_at >= ? AND created_at <= ?) OR (updated_at >= ? AND updated_at <= ?)", Time.zone.now.beginning_of_month, Time.zone.now.end_of_month, Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).all
                else
                    warranties = warranties.where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month).all
                end
            elsif params[:filter] == "lastMonth"
                if params[:include_updated_at]
                    warranties = warranties.where("(created_at >= ? AND created_at <= ?) OR (updated_at >= ? AND updated_at <= ?)", Time.zone.now.last_month.beginning_of_month, Time.zone.now.last_month.end_of_month, Time.zone.now.last_month.beginning_of_month, Time.zone.now.last_month.end_of_month).all
                else
                    warranties = warranties.where(created_at: Time.zone.now.last_month.beginning_of_month..Time.zone.now.last_month.end_of_month).all
                end
            elsif params[:filter] == "year"
                if params[:include_updated_at]
                    warranties = warranties.where("(created_at >= ? AND created_at <= ?) OR (updated_at >= ? AND updated_at <= ?)", Time.zone.now.beginning_of_year, Time.zone.now.end_of_year, Time.zone.now.beginning_of_year, Time.zone.now.end_of_year).all
                else
                    warranties = warranties.where(created_at: Time.zone.now.beginning_of_year..Time.zone.now.end_of_year).all
                end
            else
                warranties = warranties.all
            end
        else
            from = Date.parse(from)
            to = Date.parse(to)

            if params[:include_updated_at]
                warranties = warranties.where("(created_at >= ? AND created_at <= ?) OR (updated_at >= ? AND updated_at <= ?)", from.beginning_of_day, to.end_of_day, from.beginning_of_day, to.end_of_day).all
            else
                warranties = warranties.where(created_at: from.beginning_of_day..to.end_of_day).all
            end
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
                   warranties = warranties.joins(:client).where("LOWER(clients.name) LIKE ? OR LOWER(clients.email) LIKE ? 
                OR LOWER(clients.code) LIKE ? 
                OR LOWER(clients.rif) LIKE ?",
                "%#{global_filter}%", "%#{global_filter}%", "%#{global_filter}%", "%#{global_filter}%").all
            elsif global_filter_field == "item_code"
                warranties = warranties.joins(:item).where("LOWER(items.code) LIKE ?", "%#{global_filter}%").all
            elsif global_filter_field == "item_name"
                warranties = warranties.joins(:item).where("LOWER(items.name) LIKE ?", "%#{global_filter}%").all
            elsif global_filter_field == "notes"
                warranties = warranties.where("LOWER(notes) LIKE ?", "%#{global_filter}%").all
            elsif global_filter_field == "notes2"
                warranties = warranties.where("LOWER(notes2) LIKE ?", "%#{global_filter}%").all
            elsif global_filter_field == "status"
                warranties = warranties.where("LOWER(status) LIKE ?", "%#{global_filter}%").all
            elsif global_filter_field == "supplier_name"
                warranties = warranties.joins(:supplier).where("LOWER(suppliers.name) LIKE ?", "%#{global_filter}%").all
            elsif global_filter_field == "seller_name"
                warranties = warranties.joins(:seller).where("LOWER(sellers.name) LIKE ?", "%#{global_filter}%").all
            end
        end

        warranties = warranties.order(created_at: :asc)

        warranties_json = warranties.as_json(
            include: {
                client: { only: [:id, :name, :email] },
                item: { only: [:id, :name, :code] },
                user: { only: [:id, :name] },
                corporation: { only: [:id, :name] },
                supplier: { only: [:id, :name] },
                seller: { only: [:id, :name] },
                files: { only: [:blob], include: { blob: {} }}
            }
        )

        ok(warranties_json, 'Warranties retrieved successfully')
    end

    def show
        warranty_json = warranty.as_json(
            methods: [:files_count, :files_urls]
        )
        
        ok(warranty_json, 'Warranty retrieved successfully')
    end

    def create
        new_warranty = Warranty.new(warranty_params.except(:files))

        new_warranty.user_id = Current.user.id
        new_warranty.corporation_id = Current.corporation.id

        if new_warranty.save
            new_warranty.files.purge

            if warranty_params[:files].present?
                warranty_params[:files].each do |file|
                    new_warranty.files.attach(file)
                end
            end

            if new_warranty.errors.any?
                bad_request(new_warranty.errors)
            else
                ok(new_warranty, 'Warranty created')
            end
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
        params.require(:warranty).permit(
            :client_id,
            :item_id,
            :supplier_id,
            :seller_id,
            :status,
            :notes,
            :notes2,
            :quantity,
            :files => []
        )
    end

    def warranty
        @warranty ||= Warranty.find(params[:id])
    end
end