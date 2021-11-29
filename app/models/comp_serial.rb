class CompSerial < ApplicationRecord
  belongs_to :componente
  belongs_to :tipocomp    
  validates :no_serie, presence: { message: "no puede estar vacio"}
  #validates :no_activo_fijo, presence:  { message: "no puede estar vacio"}
  validates :conjunto , presence: { message: "no selecciono un conjunto"}
  self.per_page =10

  def equipo_asignado
    logger.debug "comp serial ******************"+self.id.to_s
    @relacion=RelacionComponente.find_by("componente_id = ? and comp_serial_id = ?",self.componente_id,self.id)
    if @relacion.nil?
      "no tiene equipo asignado"
    else
      Equipo.find(@relacion.equipo_id).id
    end

  end

  def informacion
    "No. de Serie :"+self.no_serie.to_s+" | Marca :"+self.componente.marca.to_s+" | Modelo :"+self.componente.modelo.to_s
  end

  def conjunto_arr
    @conjunto=self.conjunto.split(",")
  end
  def relacion_conjunto(id)
    @caracteristicas=RelacionCaracteristica.find(id)    
  end

end
