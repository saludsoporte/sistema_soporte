class Permiso < ApplicationRecord
    has_many :relacion_per_rols
    has_many :rols, through: :relacion_per_rols

    def rols=(rols)
        @rols = rols
    end

end
