class Perfil < ApplicationRecord
    has_many :relacion_perf_repos
    has_many :solicituds
    has_many :asignacions
    validates :id_usuario, presence: true
    validates :id_reporte, presence: false
    validates :id_rol, presence: true    

    def nombre
        @nombre=User.find(self.id_usuario).nombre
    end

    def nombre_personal
        User.find(self.id_usuario).nombre_completo
    end
end
