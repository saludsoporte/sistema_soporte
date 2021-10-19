class AddAreasEquipo < ActiveRecord::Migration[6.1]
  def change
    add_column :equipos, :area, :int, :default => 0
    add_column :equipos, :subdireccion, :int, :default => 0
    add_column :equipos, :direccion, :int, :default => 0
    add_column :equipos, :departamento, :int, :default => 0
    add_column :equipos, :unidad, :int, :default => 0
  end
  
end
