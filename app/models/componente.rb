class Componente < ApplicationRecord
  belongs_to :tipocomp
  has_one :relacion_componentes
  has_many :comp_serials
  self.per_page = 10

  def fecha_ingreso
    @fecha=self.created_at.to_s.split(" ")
    @fecha[0]+" : "+@fecha[1]
  end
  def fecha_modificacion
    @fecha=self.updated_at.to_s.split(" ")
    @fecha[0]+" : "+@fecha[1]
  end

  def disponibles
    @total=self.cantidad
    @ocupados=RelacionComponente.where(componente_id:self.id).count
    @disponibles=@total.to_i - @ocupados.to_i    
  end

  def relacion 
    @relacion=self.tipocomp.nombre.to_s+" : "+self.marca.to_s+" "+self.modelo.to_s
  end
end
