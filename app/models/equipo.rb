class Equipo < ApplicationRecord
  belongs_to :tipocomp
  has_many :relacion_componentes
  #validates :user_id, presence: {message: "Escoja un usuario"}
  validates :no_serie, presence: { message: "no puede estar vacio"}
  #validates :activo_fijo, presence:  { message: "no puede estar vacio"}
  validates :tipo, presence: { message: "no puede estar vacio"}  

  self.per_page = 10

  def fecha_ingreso
    @fecha=self.created_at.to_s.split(" ")
    @fecha[0]+" : "+@fecha[1]
  end

  def informacion
    @msg="Equipo : Serie "+self.no_serie+", Activo fijo "+self.activo_fijo+" "+self.tipo+" Piso:"+self.piso+" "
    if !user_id.nil?
      @msg+="Usuario: "+User.find(self.user_id).nombre_personal
    else
      @msg+="Equipo no asignado"
    end    
  end

  def user_nombre
    self.user_id.nil? ? "Sin usuario asignado" : User.find(self.user_id).nombre_personal
  end

  def qr_image
    @qrcode = RQRCode::QRCode.new("https://sesalud.slpsalud.gob.mx:4000/equipos/"+self.id.to_s)
    @svg=@qrcode.as_svg(
      offset:0,
      color:'000',        
      shape_rendering: 'crispEdges',
      module_size: 3
    )
  end
end
