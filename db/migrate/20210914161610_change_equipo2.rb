class ChangeEquipo2 < ActiveRecord::Migration[6.1]
  def change
    change_column :equipos, :user_id,:bigint,null: true,foreign_key: true
  end
end
