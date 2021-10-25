class RelacionComponente < ApplicationRecord
  belongs_to :componente
  belongs_to :equipo
  has_many :comp_serial
  self.per_page=5
end
