class Rol < ApplicationRecord    
    has_many :relacion_per_rols
    has_many :permisos , through: :relacion_per_rols
    validates :nombre, presence: { message: "requerido"}
    validates :descripcion, presence: { message: "es requerida"}

end
