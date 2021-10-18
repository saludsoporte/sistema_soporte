class CreateRelacionCaracteristicas < ActiveRecord::Migration[6.1]
  def change
    create_table :relacion_caracteristicas do |t|
      t.references :componente, null: false, foreign_key: true
      t.references :caracteristica, null: false, foreign_key: true      
      t.text :valor_caracteristica

      t.timestamps
    end
  end
end
