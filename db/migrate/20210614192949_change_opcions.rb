class ChangeOpcions < ActiveRecord::Migration[6.1]
  def change
    change_column :opcions, :tipo, :string    
  end
end
