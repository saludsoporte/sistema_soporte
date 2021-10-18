class Tipocomp < ApplicationRecord
    has_many :equipos
    validates :nombre, presence: { message: "no puede estar vacio"}  
    self.page 10
end
