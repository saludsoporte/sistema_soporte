class RelacionCaracteristica < ApplicationRecord
  belongs_to :componente
  belongs_to :caracteristica
  self.per_page = 5
end
