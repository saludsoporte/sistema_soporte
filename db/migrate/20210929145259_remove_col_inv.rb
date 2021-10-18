class RemoveColInv < ActiveRecord::Migration[6.1]
  def change
    remove_column :inventarios, :articulo_id, :integer
    remove_column :inventarios, :fecha_ingreso, :date
  end
end
