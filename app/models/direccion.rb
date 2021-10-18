class Direccion < ApplicationRecord
    self.per_page = 10
    def nom
        self.nombre.titleize
    end
end
