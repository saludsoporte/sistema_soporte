class AddSerieActivoFijo < ActiveRecord::Migration[6.1]
  def change   
    add_column :componentes, :disponible, :boolean, :default => true
  end
end
