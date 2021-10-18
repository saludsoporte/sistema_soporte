class AddAreaToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :area, :string
  end
end
