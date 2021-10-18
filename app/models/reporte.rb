class Reporte < ApplicationRecord
  belongs_to :solicitud
  has_one :estado
  has_many :asignacions
  has_many :actividads
  has_one :user
  
  def nombre_tecnico
    @nombre=Asignacion.where("reporte_id=?",self.id).last
    @nombre[:nombre_user]
  end

  def estado
    @estado=Estado.find(self.estado_id).estado
  end
  def descripcion_edo
    @estado=Estado.find(self.estado_id).descripcion
  end
  def hora_ing
    @hora=self.hora_ingreso.to_s.split(" ")
    @hora[1]
  end
  def hora_egr
    @hora=self.hora_egreso.to_s.split(" ")
    @hora[1]
  end
end
