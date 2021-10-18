class Solicitud < ApplicationRecord
  has_one :reporte
  belongs_to :perfil 
  has_one :estado  
  validates :"descripcion_sencilla", presence: {message: "es requerida"}
  validates :solicitante_id,presence: {message: "es requerido"}
  validates :tecnico_id, presence: {message: "es requerido"}
  validates :serie, presence: {message: "requerido"}
  
  self.per_page = 10

  def revisar_cad
    if !self.fecha_termino.nil? && !self.caducidad.nil?    
      if self.fecha_termino < self.caducidad
        false
      elsif self.fecha_termino > self.caducidad
        true
      end
    else
      false
    end 
  end
  def estado
    Estado.find(self.estado_id).estado
  end

  def tecnico
    if self.tecnico_id.nil?
      @@tecnico="No hay tecnico asignado"
    else
      @user=User.find(self.tecnico_id)
      @user.nombre_personal
    end
  end
  def reporte_id_edo
    @reporte=Reporte.find_by("solicitud_id=?",self.id)
    if !@reporte.nil?
      @reporte.estado_id
    else
      @reporte=[estado_id:11]
    end
  end
  def  reporte_edo
      @reporte=Reporte.find_by("solicitud_id=?",self.id)
      if @reporte.nil?
        Estado.find(11).estado 
      else
        Estado.find(@reporte.estado_id).estado
      end
  end
  def sol_edo_descripcion
    @sol_edo=Estado.find(self.estado_id).descripcion
  end
  def  reporte_edo_descripcion
    @reporte=Reporte.find_by("solicitud_id=?",self.id)
    if @reporte.nil?
      Estado.find(11).descripcion
    else
      Estado.find(@reporte.estado_id).descripcion
    end
  end
end
