class CreateUnidads < ActiveRecord::Migration[6.1]
  def change
    create_table :unidads do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
