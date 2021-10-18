class CreatePerfils < ActiveRecord::Migration[6.1]
  def change
    create_table :perfils do |t|
      t.integer :id_usuario
      t.integer :id_rel_perf_rols
      t.integer :id_rol   

      t.timestamps
    end
  end
end
