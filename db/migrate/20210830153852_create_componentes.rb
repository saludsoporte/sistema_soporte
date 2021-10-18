class CreateComponentes < ActiveRecord::Migration[6.1]
  def change
    create_table :componentes do |t|
      t.references :tipocomp, null: false, foreign_key: true
      t.string :modelo
      t.string :marca

      t.timestamps
    end
  end
end
