class RelacionComponente < ApplicationRecord
  belongs_to :componente
  belongs_to :equipo
  
  self.per_page=5

  def serial
    @serial=CompSerial.find(self.comp_serial_id)
  end
end
