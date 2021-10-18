class AddTipoRelSolOp < ActiveRecord::Migration[6.1]
  def change
    add_column :relacion_sol_opts, :tipo, :string
    add_column :relacion_sol_opts, :opcion_av_id, :integer
  end
end
