class CreateInventarios < ActiveRecord::Migration[6.1]
  def change
    create_table :inventarios do |t|
      t.integer :articulo_id
      t.integer :tipocomp_id
      t.integer :cantidad
      t.integer :disponibles
      t.date :fecha_ingreso

      t.timestamps
    end
  end
end
