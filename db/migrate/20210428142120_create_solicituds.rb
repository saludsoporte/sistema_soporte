class CreateSolicituds < ActiveRecord::Migration[6.1]
  def change
    create_table :solicituds do |t|
      t.references :perfil, null: false, foreign_key: true
      t.string :nombre_user
      t.integer :estado_id
      t.date :fecha_inicio
      t.date :fecha_termino
      t.integer :opciones_rel
      t.boolean :hardware
      t.boolean :software

      t.timestamps
    end
  end
end
