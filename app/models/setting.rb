class Setting < RailsSettings::Base
  field :order_statuses, type: :array, default: %w[creado procesado enviado entregado]
end
