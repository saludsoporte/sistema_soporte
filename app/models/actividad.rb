class Actividad < ApplicationRecord
  belongs_to :reporte
  belongs_to :perfil  
  validates :descripcion, presence: { message: "no puede estar vacio"}

  def nombre_tecnico
      @nombre = Perfil.find(self.perfil_id).nombre
  end
  
  def hora_actividad
    @hora=self.hora.to_s.split(" ")
    @hora[1]
  end

end
