class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_writer :login
  validate :validate_username
  validate :id
  validate :nombre_completo
  validate :username
  has_many :reportes
  has_many :solicituds
  has_one :equipo
  self.per_page = 10
  scope :ultimos, ->{order("id asc")}
  def login
    @login || self.username || self.email
  end

  def equipo_asignado
    @equipo=Equipo.find_by("user_id = ? ",self.id)    
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value",{:value => login.downcase}]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
  def nombre_personal
    @user=User.find(self.id)
    (@user.nombre+" "+@user.apellido_paterno+" "+@user.apellido_materno).titleize
  end

  def perfil_id
    @@perfil=Perfil.find_by(id_usuario:self.id).id
  end
  def rol
    @perfil=Perfil.find_by(id_usuario:self.id)
    if !@perfil.nil?
      @@rol=Perfil.find_by(id_usuario:self.id).id_rol
      Rol.find(@@rol).nombre
    end
  end  
  def rol_id
    @@rol=Perfil.find_by(id_usuario:self.id).id_rol    
  end 
  def permisos
    @@rol=Perfil.find_by(id_usuario:self.id).id_rol
    @id_rol=Rol.find(@@rol).id  
    @permisos=RelacionPerRol.where(rol_id:@id_rol).select(:permiso_id)
    
    @lista_permisos=Array(nil)
    @permisos.each do |pp|
      @lista_permisos.append(pp.permiso_id)
    end    
    @lista_permisos
  end

  def area_nombre
    unless self.area.nil?
      if self.area == 0 
        "No tiene área asociada"
      else
        Area.find(self.area).nombre.titleize
      end
    else
      "No tiene unidad asociada"
    end
  end

  def subdireccion_nombre
    unless self.subdireccion.nil?
      if self.subdireccion == 0
        "No tiene subdirección asociada"
      else
        Subdireccion.find(self.subdireccion).nombre.titleize
      end
    else
      "No tiene unidad asociada"
    end
  end
  #$2a$12$i4eeMlPcTJvOaZ8R/y0mJeiA1mBy5thQhyH9iSMtTVGgZWoBdVmli
  def unidad_nombre
    unless self.unidad.nil?
      if self.unidad == 0
        "No tiene unidad asociada"
      else
        Unidad.find(self.unidad).nombre.titleize
      end
    else
      "No tiene unidad asociada"
    end

  end
  def direccion_nombre
    unless self.direccion.nil?
      if self.direccion == 0
        "No tiene dirección asociada"
      else
        Direccion.find(self.direccion).nombre.titleize
      end
    else
      "No tiene unidad asociada"
    end
  end

  def nombre_con_id
    self.id.to_s+" -> "+self.nombre_completo.titleize+"| Depto:"+self.departamento_nombre.to_s
  end

  def departamento_nombre
    unless self.departamento.nil?
      if self.departamento==0
        "No tiene departamento asociado"
      else
        Departamento.find(self.departamento).nombre.titleize
      end
    else
      "No tiene unidad asociada"
    end
    
  end
  def validate_username
    if User.where(email: username).exists?     
      errors.add(:username, :invalid)
    end
  end
end
