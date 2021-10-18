class ChangeEquipo < ActiveRecord::Migration[6.1]
  def change
    
    change_column :equipos, :user_id,:bigint,null: true,foreign_key: true
    #Ex:- :null => false
  end
end
