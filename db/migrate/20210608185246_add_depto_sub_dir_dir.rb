class AddDeptoSubDirDir < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :subdireccion, :integer
    add_column :users, :direccion, :integer
    add_column :users, :departamento, :integer    
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
