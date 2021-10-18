class AddColumVoboReporteSol < ActiveRecord::Migration[6.1]
  def change
    add_column :reportes, :vobo_repo, :boolean, :default => false
    #Ex:- :default =>''
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    add_column :solicituds, :vobo_sol, :boolean, :default => false
  end
end
