Rails.application.routes.draw do

  get 'index/show'
  get 'pages/qr_code_generator'
  get 'folios/index'
  get 'folio/index'
  devise_for :users
  root 'perfils#index'
  get "users/usuario_nuevo", to: "users#usuario_nuevo"
  post "folios/reporte", to: "folios#reporte"

  get  "solicituds/buscar_por_nombre", to: "solicituds#buscar_por_nombre"

  get "folios/:id/vobo", to: "folios#vobo"
  get 'relacion_per_rols/:id/agregar', to: "relacion_per_rols#agregar"
  get "perfils/carga_relacion", to: "perfils#carga_relacion"  
  
  get "relacion_componentes/carga_componente", to: "relacion_componentes#carga_componente"
  get "relacion_componentes/carga_caracteristicas", to: "relacion_componentes#carga_caracteristicas"
  get "relacion_componentes/:id/carga_caracteristicas", to: "relacion_componentes#carga_caracteristicas"
  get "relacion_componentes/carga_serial", to: "relacion_componentes#carga_serial"
  get "relacion_caracteristicas/carga_conjunto", to: "relacion_caracteristicas#carga_conjunto"
  get "comp_serials/carga_conjunto", to: "comp_serials#carga_conjunto"
  get "componentes/carga_conjunto", to: "componentes#carga_conjunto"

  get "equipos/quitar_asignacion", to: "equipos#quitar_asignacion"
  get "solicituds/buscar_user", to: "solicituds#buscar_user"
  get "comp_serials/buscar_eq", to: "comp_serials#buscar_eq"

  get "perfils/cargar_tabla", to: "perfils#cargar_tabla"

  get "inventarios/cargar_tabla", to: "inventarios#cargar_tabla"

  get "solicituds/cargar_solicitudes_por_user", to: "solicituds#cargar_solicitudes_por_user"

  get "relacion_caracteristicas/cargar_conjuntos", to: "relacion_caracteristicas#cargar_conjuntos"
  get "relacion_caracteristicas/new_cargar_conjuntos", to: "relacion_caracteristicas#new_cargar_conjuntos"
  get "inventarios/carga_inventario", to: "invectarios#carga_inventario"
  
  get "reportes/crear_reporte", to: "reportes#crear_reporte"

  get "comp_serials/asignar_equipo", to: "comp_serials#asignar_equipo"
  get "equipos/cargar_equipo_completo", to: "equipos#cargar_equipo_completo"

  get "perfils/set_tam", to: "perfils#set_tam"  
  get "solicituds/carga_relacion", to: "solicituds#carga_relacion"
  get "reportes/carga_pdf", to: "reportes#carga_pdf"
  
  get "solicituds/vobo_admin",to: "solicituds#vobo_admin"

  post "relacion_sol_opts/eliminar_relacion", to: "relacion_sol_opts#eliminar_relacion"
  post '/users/usuario_add', to: 'users#usuario_add'
  patch '/solicituds/tec_up', to: 'solicituds#tec_up'
  patch '/solicituds/sol', to: 'solicituds#sol'
  get "solicituds/cancel_sol",to: "solicituds#cancel_sol"  
  
controller :pages do
  get :qr_code_generator
  get :qr_code_download
end
  #post "asignacions/:id/reasignar_update", to: "asignacions#reasignar_update"
  #get "reordens/:id/carga", to: "reordens#carga"
  resources :users,
            :perfils,
            :rols,
            :permisos,
            :relacion_per_rols,
            :opcions,
            :solicituds,
            :estados,
            :relacion_sol_opts,
            :reportes,
            :asignacions,
            :actividads,
            :folios,
            :mailers,
            :opcion_avanzadas,
            :areas,
            :unidads,
            :departamentos,
            :direccions,
            :subdireccions,
            :equipos,
            :relacion_componentes,
            :componentes,
            :tipocomps,
            :caracteristicas,
            :relacion_caracteristicas,
            :asignadors,
            :inventarios,
            :comp_serials,
            :log_equipos
                        


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
