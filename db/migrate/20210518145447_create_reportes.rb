class CreateReportes < ActiveRecord::Migration[6.1]
  def change
    create_table :reportes do |t|
      t.references :solicitud, null: false, foreign_key: true
      t.references :estado, null: false, foreign_key: true
      t.date :fecha_ingreso
      t.date :fecha_entrega
      t.text :descripcion_sencilla
      t.integer :asignacion_id, null: false
      t.string :unidad
      t.string :direccion
      t.string :subdireccion
      t.string :departamento

      t.timestamps
    end
  end
end
