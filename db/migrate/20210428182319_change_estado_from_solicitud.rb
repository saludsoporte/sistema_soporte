class ChangeEstadoFromSolicitud < ActiveRecord::Migration[6.1]
  def change
    remove_column :solicituds, :estado
  end
end
