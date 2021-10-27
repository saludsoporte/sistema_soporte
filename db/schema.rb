# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_27_141754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "actividads", force: :cascade do |t|
    t.bigint "reporte_id", null: false
    t.text "descripcion", null: false
    t.date "fecha"
    t.time "hora"
    t.bigint "perfil_id", null: false
    t.string "tipo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["perfil_id"], name: "index_actividads_on_perfil_id"
    t.index ["reporte_id"], name: "index_actividads_on_reporte_id"
  end

  create_table "areas", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "asignacions", force: :cascade do |t|
    t.bigint "reporte_id", null: false
    t.bigint "perfil_id", null: false
    t.date "fecha_asignacion"
    t.string "nombre_user"
    t.boolean "reasignada", default: false
    t.text "motivo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "a_reasignar", default: false
    t.index ["perfil_id"], name: "index_asignacions_on_perfil_id"
    t.index ["reporte_id"], name: "index_asignacions_on_reporte_id"
  end

  create_table "caracteristicas", force: :cascade do |t|
    t.text "nombre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comp_serials", force: :cascade do |t|
    t.bigint "componente_id", null: false
    t.string "no_serie"
    t.string "no_activo_fijo"
    t.bigint "tipocomp_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "disponible", default: true
    t.string "conjunto"
    t.index ["componente_id"], name: "index_comp_serials_on_componente_id"
    t.index ["tipocomp_id"], name: "index_comp_serials_on_tipocomp_id"
  end

  create_table "componentes", force: :cascade do |t|
    t.bigint "tipocomp_id", null: false
    t.string "modelo"
    t.string "marca"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "inventariado", default: false
    t.index ["tipocomp_id"], name: "index_componentes_on_tipocomp_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.string "progress_stage"
    t.integer "progress_current", default: 0
    t.integer "progress_max", default: 0
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "departamentos", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "direccions", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "equipos", force: :cascade do |t|
    t.string "no_serie"
    t.string "activo_fijo"
    t.string "tipo"
    t.string "piso"
    t.string "folio"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "tipocomp_id"
    t.integer "area", default: 0
    t.integer "subdireccion", default: 0
    t.integer "direccion", default: 0
    t.integer "departamento", default: 0
    t.integer "unidad", default: 0
    t.index ["tipocomp_id"], name: "index_equipos_on_tipocomp_id"
    t.index ["user_id"], name: "index_equipos_on_user_id"
  end

  create_table "estados", force: :cascade do |t|
    t.string "estado"
    t.text "descripcion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tipo"
  end

  create_table "inventarios", force: :cascade do |t|
    t.integer "tipocomp_id"
    t.integer "cantidad"
    t.integer "disponibles"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "opcion_avanzadas", force: :cascade do |t|
    t.string "nombre"
    t.integer "opcion_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "opcions", force: :cascade do |t|
    t.text "opcion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tipo"
  end

  create_table "perfils", force: :cascade do |t|
    t.integer "id_usuario"
    t.integer "id_reporte"
    t.integer "id_rol"
    t.integer "id_permiso_rel"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "disponible", default: false
  end

  create_table "permisos", force: :cascade do |t|
    t.string "permiso"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "relacion_caracteristicas", force: :cascade do |t|
    t.bigint "componente_id", null: false
    t.bigint "caracteristica_id", null: false
    t.text "valor_caracteristica"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["caracteristica_id"], name: "index_relacion_caracteristicas_on_caracteristica_id"
    t.index ["componente_id"], name: "index_relacion_caracteristicas_on_componente_id"
  end

  create_table "relacion_componentes", force: :cascade do |t|
    t.bigint "componente_id", null: false
    t.bigint "equipo_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "comp_serial_id"
    t.index ["comp_serial_id"], name: "index_relacion_componentes_on_comp_serial_id"
    t.index ["componente_id"], name: "index_relacion_componentes_on_componente_id"
    t.index ["equipo_id"], name: "index_relacion_componentes_on_equipo_id"
  end

  create_table "relacion_per_rols", force: :cascade do |t|
    t.bigint "rol_id", null: false
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.bigint "permiso_id", null: false
    t.index ["permiso_id"], name: "index_relacion_per_rols_on_permiso_id"
    t.index ["rol_id"], name: "index_relacion_per_rols_on_rol_id"
  end

  create_table "relacion_perf_rols", force: :cascade do |t|
    t.integer "id_usuario"
    t.bigint "id_perfil_id"
    t.bigint "id_reporte_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id_perfil_id"], name: "index_relacion_perf_rols_on_id_perfil_id"
    t.index ["id_reporte_id"], name: "index_relacion_perf_rols_on_id_reporte_id"
  end

  create_table "relacion_sol_opts", force: :cascade do |t|
    t.bigint "solicitud_id", null: false
    t.bigint "opcion_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "opcion_nombre"
    t.text "descripcion_sencilla"
    t.string "tipo"
    t.integer "opcion_av_id"
    t.index ["opcion_id"], name: "index_relacion_sol_opts_on_opcion_id"
    t.index ["solicitud_id"], name: "index_relacion_sol_opts_on_solicitud_id"
  end

  create_table "reportes", force: :cascade do |t|
    t.bigint "solicitud_id", null: false
    t.bigint "estado_id", null: false
    t.date "fecha_ingreso"
    t.date "fecha_entrega"
    t.text "descripcion_sencilla"
    t.string "area"
    t.string "direccion"
    t.string "subdireccion"
    t.string "departamento"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "folio"
    t.boolean "vobo_repo", default: false
    t.bigint "user_id"
    t.time "hora_ingreso"
    t.time "hora_egreso"
    t.date "caducidad"
    t.text "serie"
    t.index ["estado_id"], name: "index_reportes_on_estado_id"
    t.index ["solicitud_id"], name: "index_reportes_on_solicitud_id"
    t.index ["user_id"], name: "index_reportes_on_user_id"
  end

  create_table "rols", force: :cascade do |t|
    t.string "nombre"
    t.text "descripcion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "solicituds", force: :cascade do |t|
    t.bigint "perfil_id", null: false
    t.string "nombre_user"
    t.date "fecha_inicio"
    t.date "fecha_termino"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "estado_id"
    t.integer "tecnico_id"
    t.string "descripcion_sencilla", limit: 100000
    t.integer "usuario_captura"
    t.boolean "vobo_sol", default: false
    t.integer "solicitante_id"
    t.date "caducidad"
    t.text "serie"
    t.index ["perfil_id"], name: "index_solicituds_on_perfil_id"
  end

  create_table "subdireccions", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tipocomps", force: :cascade do |t|
    t.text "nombre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "unidads", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "nombre", default: "", null: false
    t.string "apellido_paterno", default: "", null: false
    t.string "apellido_materno", default: "", null: false
    t.string "email", default: ""
    t.string "encrypted_password", default: ""
    t.string "permission_level"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "perfil", default: false
    t.integer "area"
    t.string "nombre_completo"
    t.integer "subdireccion"
    t.integer "direccion"
    t.integer "departamento"
    t.integer "unidad"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "actividads", "perfils"
  add_foreign_key "actividads", "reportes"
  add_foreign_key "asignacions", "perfils"
  add_foreign_key "asignacions", "reportes"
  add_foreign_key "comp_serials", "componentes"
  add_foreign_key "comp_serials", "tipocomps"
  add_foreign_key "componentes", "tipocomps"
  add_foreign_key "equipos", "tipocomps"
  add_foreign_key "equipos", "users"
  add_foreign_key "relacion_caracteristicas", "caracteristicas"
  add_foreign_key "relacion_caracteristicas", "componentes"
  add_foreign_key "relacion_componentes", "comp_serials"
  add_foreign_key "relacion_componentes", "componentes"
  add_foreign_key "relacion_componentes", "equipos"
  add_foreign_key "relacion_per_rols", "permisos"
  add_foreign_key "relacion_per_rols", "rols"
  add_foreign_key "relacion_sol_opts", "opcions"
  add_foreign_key "relacion_sol_opts", "solicituds"
  add_foreign_key "reportes", "estados"
  add_foreign_key "reportes", "solicituds"
  add_foreign_key "reportes", "users"
  add_foreign_key "solicituds", "perfils"
end
