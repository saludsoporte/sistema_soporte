class CreateLogEquipos < ActiveRecord::Migration[6.1]
  def change
    create_table :log_equipos do |t|
      t.string :accion
      t.text :descripcion
      t.string :user_asignado
      t.string :user_asignado_id
      t.string :equipo_id

      t.timestamps
    end
    add_index :log_equipos, :user_asignado_id
    add_index :log_equipos, :equipo_id
  end
end
