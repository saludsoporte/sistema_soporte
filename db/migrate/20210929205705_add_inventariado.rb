class AddInventariado < ActiveRecord::Migration[6.1]
  def change
    add_column :componentes ,:inventariado,  :boolean, :default => false
    add_column :relacion_caracteristicas, :conjunto, :int    
    add_column :comp_serials, :conjunto, :int
    add_reference :relacion_componentes, :comp_serial, index:true
    add_foreign_key :relacion_componentes, :comp_serials
  end
end
