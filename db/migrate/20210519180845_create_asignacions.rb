class CreateAsignacions < ActiveRecord::Migration[6.1]
  def change
    create_table :asignacions do |t|
      t.references :reporte, null: false, foreign_key: true
      t.references :perfil, null: false, foreign_key: true
      t.date :fecha_asignacion
      t.string :nombre_user
      t.boolean :reasignada,default:false
      t.text :motivo

      t.timestamps
    end
  end
end
