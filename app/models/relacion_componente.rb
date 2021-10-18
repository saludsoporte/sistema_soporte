class RelacionComponente < ApplicationRecord
  belongs_to :componente
  belongs_to :equipo
  belongs_to :comp_serial
  self.per_page=5
end
