class CreateOpcions < ActiveRecord::Migration[6.1]
  def change
    create_table :opcions do |t|
      t.text :opcion

      t.timestamps
    end
  end
end
