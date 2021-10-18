class CreatePermisos < ActiveRecord::Migration[6.1]
  def change
    create_table :permisos do |t|
      t.string :permiso

      t.timestamps
    end
  end
end
