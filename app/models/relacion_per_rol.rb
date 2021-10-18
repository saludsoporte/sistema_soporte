class RelacionPerRol < ApplicationRecord

  validates :rol_id, presence: :true
  validates :permiso_id, presence:  { message: "no puede estar vacio"}

  def permiso
    Permiso.find(self.permiso_id).permiso
  end

end
