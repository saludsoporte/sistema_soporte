class CreateEquipos < ActiveRecord::Migration[6.1]
  def change
    create_table :equipos do |t|
      t.string :no_serie
      t.string :activo_fijo
      t.string :tipo
      t.string :piso
      t.string :folio
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
