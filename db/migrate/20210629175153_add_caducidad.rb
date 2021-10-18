class AddCaducidad < ActiveRecord::Migration[6.1]
  def change
    add_column :solicituds, :caducidad, :date
    add_column :reportes, :caducidad, :date
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
