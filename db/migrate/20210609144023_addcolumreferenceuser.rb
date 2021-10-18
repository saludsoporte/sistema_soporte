class Addcolumreferenceuser < ActiveRecord::Migration[6.1]
  def change
    add_reference :reportes, :user, foreign_key: true
  end
end
