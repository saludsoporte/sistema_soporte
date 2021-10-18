class AddIdPermisoToRelacionPerRols < ActiveRecord::Migration[6.1]
  def change
    add_reference :relacion_per_rols, :permiso, null: false, foreign_key: true
  end
end
