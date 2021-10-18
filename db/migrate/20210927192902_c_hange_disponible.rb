class CHangeDisponible < ActiveRecord::Migration[6.1]
  def change
    remove_column :componentes , :disponible, :boolean
    add_column :comp_serials, :disponible, :boolean, :default => true
  end
end
