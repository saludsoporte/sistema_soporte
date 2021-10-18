class AddColumnHoraRepo < ActiveRecord::Migration[6.1]
  def change
    add_column :reportes, :hora_ingreso, :time
    add_column :reportes, :hora_egreso, :time
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
