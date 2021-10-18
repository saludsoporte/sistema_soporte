class CreateOpcionAvanzadas < ActiveRecord::Migration[6.1]
  def change
    create_table :opcion_avanzadas do |t|
      t.string :nombre
      t.integer :opcion_id

      t.timestamps
    end
  end
end
