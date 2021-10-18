class DelHardSoftSol < ActiveRecord::Migration[6.1]
  def change
    remove_column :solicituds, :hardware
    remove_column :solicituds, :software
  end
end
