class WarrantyStatesController < ApplicationController
    def index
        warranty_states = WarrantyState.all
        warranty_states_json = warranty_states.as_json

        ok(warranty_states_json, 'Warranty states retrieved successfully')
    end

    def create
        pp "###############"
        pp warranty_state_params
        pp "###############"
        new_warranty_state = WarrantyState.new(warranty_state_params)

        if new_warranty_state.save
            ok(new_warranty_state, 'Warranty state created')
        else
            bad_request(new_warranty_state.errors)
        end
    end

    def destroy
        ok(warranty_state, 'Warranty state deleted') if warranty_state.destroy
    end

    private

    def warranty_state_params
        params.permit(:name, :color)
    end

    def warranty_state
        @warranty_state ||= WarrantyState.find(params[:id])
    end
end