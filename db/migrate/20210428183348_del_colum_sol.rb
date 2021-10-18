class DelColumSol < ActiveRecord::Migration[6.1]
  def change
    remove_column :solicituds, :opciones_rel
  end
end
