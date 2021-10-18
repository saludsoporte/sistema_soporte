class CreateEstados < ActiveRecord::Migration[6.1]
  def change
    create_table :estados do |t|
      t.string :estado
      t.text :descripcion

      t.timestamps
    end
  end
end
