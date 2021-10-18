class CreateDireccions < ActiveRecord::Migration[6.1]
  def change
    create_table :direccions do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
