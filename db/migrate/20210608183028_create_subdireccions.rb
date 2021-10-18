class CreateSubdireccions < ActiveRecord::Migration[6.1]
  def change
    create_table :subdireccions do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
