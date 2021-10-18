class AddColumAsignacion < ActiveRecord::Migration[6.1]
  def change
    add_column :asignacions, :a_reasignar, :boolean, default:false
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
