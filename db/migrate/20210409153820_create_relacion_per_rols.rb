class CreateRelacionPerRols < ActiveRecord::Migration[6.1]
  def change
    create_table :relacion_per_rols do |t|
      t.references :rol, null: false, foreign_key: true
      t.integer :id_permiso

      t.timestamps
    end
  end
end
