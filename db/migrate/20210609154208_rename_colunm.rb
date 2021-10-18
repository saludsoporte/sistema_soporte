class RenameColunm < ActiveRecord::Migration[6.1]
  def change
    rename_column :reportes, :unidad, :area
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
