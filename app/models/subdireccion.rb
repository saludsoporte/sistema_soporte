class Subdireccion < ApplicationRecord
    self.per_page = 10
    def nom
        self.nombre.titleize
    end
end
