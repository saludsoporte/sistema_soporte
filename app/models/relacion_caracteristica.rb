class RelacionCaracteristica < ApplicationRecord
  belongs_to :componente
  belongs_to :caracteristica
  validates :componente_id, presence: { message: "no puede estar vacio"}
  validates :caracteristica_id, presence: { message: "no puede estar vacio"}
  validates :valor_caracteristica, presence: { message: "no puede estar vacio"}

  self.per_page = 5
end
