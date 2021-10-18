class EditAreaUser < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :area, :string, default: "", null: false
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
