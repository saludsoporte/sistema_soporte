class Asignacion < ApplicationRecord
  belongs_to :reporte
  belongs_to :perfil
  #validates :reasignada, presence: { message: "requerido"}
  validates :motivo, presence:{ message: "es requerido"}
end
