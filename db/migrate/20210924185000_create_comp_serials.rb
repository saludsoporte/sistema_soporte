class CreateCompSerials < ActiveRecord::Migration[6.1]
  def change
    create_table :comp_serials do |t|
      t.references :componente, null: false, foreign_key: true
      t.string :no_serie
      t.string :no_activo_fijo
      t.references :tipocomp, null: false, foreign_key: true

      t.timestamps
    end
  end
end
