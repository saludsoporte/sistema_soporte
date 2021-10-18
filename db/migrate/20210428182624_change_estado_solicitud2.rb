class ChangeEstadoSolicitud2 < ActiveRecord::Migration[6.1]
  def change
    add_column :solicituds, :estado_id, :integer
  end
end
