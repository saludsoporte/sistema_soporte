class CreateRelacionPerfRols < ActiveRecord::Migration[6.1]
  def change
    create_table :relacion_perf_rols do |t|
      t.integer :id_usuario
      t.references :id_perfil
      t.references :id_reporte

      t.timestamps
    end
  end
end
