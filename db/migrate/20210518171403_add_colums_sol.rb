class AddColumsSol < ActiveRecord::Migration[6.1]
  def change
    add_column :solicituds, :descripcion_sencilla, :string, :limit => 50
    add_column :solicituds, :usuario_captura, :integer
    #Ex:- :limit => 40
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
