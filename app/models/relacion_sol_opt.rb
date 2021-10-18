class RelacionSolOpt < ApplicationRecord

  validates :opcion_id, presence: true
  validates :opcion_av_id, presence: true
  def opcion
    Opcion.find(self.opcion_id).opcion
  end

  def estado_sol
    @solicitud=Solicitud.find(self.solicitud_id)
    @edo=Estado.find(@solicitud.estado_id)
  end
end
