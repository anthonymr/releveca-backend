class Setting < RailsSettings::Base
  field :order_statuses, type: :array, default: %w[creado procesado enviado entregado]
  field :history_statuses, type: :array, default: %w[creado procesado enviado entregado no\ aprobado aprobado]
  field :modules, type: :hash, default: {
    items: {
      name: 'Artículos',
      icon: 'fa-solid fa-boxes-stacked',
      submodules: []
    },
    clients: {
      name: 'Clientes',
      icon: 'fa-solid fa-user-tie',
      submodules: []
    },
    orders: {
      name: 'Pedidos',
      icon: 'fa-solid fa-receipt',
      submodules: []
    },
    paiments: {
      name: 'Pagos',
      icon: 'fa-solid fa-money-bill',
      submodules: []
    },
    configurations: {
      name: 'Configuraciones',
      icon: 'fa-solid fa-cog',
      submodules: []
    },
    users: {
      name: 'Usuarios',
      icon: 'fa-solid fa-user',
      submodules: []
    },
    permissions: {
      name: 'Permisos',
      icon: 'fa-solid fa-user-lock',
      submodules: []
    },
    corporations: {
      name: 'Corporaciones',
      icon: 'fa-solid fa-building',
      submodules: []
    }
  }
end
