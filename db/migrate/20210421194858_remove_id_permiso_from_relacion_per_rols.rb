class RemoveIdPermisoFromRelacionPerRols < ActiveRecord::Migration[6.1]
  def change
    remove_column :relacion_per_rols, :id_permiso, :string
  end
end
