class RelacionCaracteristica < ApplicationRecord
  belongs_to :componente
  belongs_to :caracteristica
  self.per_page = 5

  def conjuntos
   @@conjunto="Conjunto : "+self.conjunto.to_s
  end
end
