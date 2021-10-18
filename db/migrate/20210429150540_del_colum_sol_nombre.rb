class DelColumSolNombre < ActiveRecord::Migration[6.1]
  def change
    remove_column :solicituds, :opcion_nom
  end
end
