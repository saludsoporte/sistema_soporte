class AddColunmsUser < ActiveRecord::Migration[6.1]
  def change
     
    add_column :users, :perfil, :boolean, :default => false
    remove_column :users, :area, :string
    add_column :users, :area, :integer
    add_column :users, :nombre_completo, :string
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
    #Ex:- :default =>''
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
