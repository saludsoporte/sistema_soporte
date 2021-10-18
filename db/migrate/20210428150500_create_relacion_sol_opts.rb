class CreateRelacionSolOpts < ActiveRecord::Migration[6.1]
  def change
    create_table :relacion_sol_opts do |t|
      t.references :solicitud, null: false, foreign_key: true
      t.references :opcion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
