class AddRelacionNompre < ActiveRecord::Migration[6.1]
  def change
    add_column :relacion_sol_opts, :opcion_nombre, :string
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
