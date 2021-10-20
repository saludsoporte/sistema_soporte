class CompSerial < ApplicationRecord
  belongs_to :componente
  belongs_to :tipocomp  
  
  validates :no_serie, presence: { message: "no puede estar vacio"}
  validates :no_activo_fijo, presence:  { message: "no puede estar vacio"}
  validates :conjunto , presence: { message: "no selecciono un conjunto"}
  self.per_page =10

  def equipo_asignado
    @relacion=RelacionComponente.find_by("componente_id = ? and comp_serial_id = ?",self.componente_id,self.id)
    Equipo.find(@relacion.equipo_id).id
  end

end
