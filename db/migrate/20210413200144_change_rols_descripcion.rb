class ChangeRolsDescripcion < ActiveRecord::Migration[6.1]
  def change
    change_column :rols, :descripcion, :text
  end
end
