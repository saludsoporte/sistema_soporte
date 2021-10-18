class CreateTipocomps < ActiveRecord::Migration[6.1]
  def change
    create_table :tipocomps do |t|
      t.text :nombre

      t.timestamps
    end
  end
end
