class ChangeEstadoSolicitud < ActiveRecord::Migration[6.1]
  def change
    rename_column :solicituds, :estado_id, :estado
  end
end
