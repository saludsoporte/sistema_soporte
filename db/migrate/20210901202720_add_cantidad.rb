class AddCantidad < ActiveRecord::Migration[6.1]
  def change
    add_column :componentes, :cantidad, :int
  end
end
