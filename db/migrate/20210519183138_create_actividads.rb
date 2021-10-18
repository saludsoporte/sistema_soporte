class CreateActividads < ActiveRecord::Migration[6.1]
  def change
    create_table :actividads do |t|
      t.references :reporte, null: false, foreign_key: true
      t.text :descripcion, null: false
      t.date :fecha
      t.time :hora
      t.references :perfil, null: false, foreign_key: true
      t.string :tipo

      t.timestamps
    end
  end
end
