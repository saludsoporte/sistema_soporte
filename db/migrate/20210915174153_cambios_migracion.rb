class CambiosMigracion < ActiveRecord::Migration[6.1]
  def change
    remove_column :componentes, :cantidad , :integer   
    add_reference :equipos ,:tipocomp,index: true,foreign_key: true
  end
end
