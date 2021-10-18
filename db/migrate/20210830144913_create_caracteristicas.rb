class CreateCaracteristicas < ActiveRecord::Migration[6.1]
  def change
    create_table :caracteristicas do |t|
      t.text :nombre

      t.timestamps
    end
  end
end
