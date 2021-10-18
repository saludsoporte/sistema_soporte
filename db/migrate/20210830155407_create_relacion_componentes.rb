class CreateRelacionComponentes < ActiveRecord::Migration[6.1]
  def change
    create_table :relacion_componentes do |t|
      t.references :componente, null: false, foreign_key: true
      t.references :equipo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
