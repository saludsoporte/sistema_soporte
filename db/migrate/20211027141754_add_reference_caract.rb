class AddReferenceCaract < ActiveRecord::Migration[6.1]
  def change
    remove_column :comp_serials , :conjunto, :integer
    remove_column :relacion_caracteristicas , :conjunto, :integer
    add_column :comp_serials, :conjunto, :string    
  end
end
