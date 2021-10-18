class RemoveAsignacion < ActiveRecord::Migration[6.1]
  def change
    remove_column :reportes, :asignacion_id
  end
end
