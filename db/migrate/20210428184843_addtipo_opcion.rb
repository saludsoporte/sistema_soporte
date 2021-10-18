class AddtipoOpcion < ActiveRecord::Migration[6.1]
  def change
    add_column :opcions, :tipo, :binary
  end
end
