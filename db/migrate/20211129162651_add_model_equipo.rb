class AddModelEquipo < ActiveRecord::Migration[6.1]
  def change
    add_column  :equipos, :modelo ,:string
  end
end
