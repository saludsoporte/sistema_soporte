class LogEquiposController < ApplicationController
  def index
    @logs_equipo=LogEquipo.where("equipo_id=?",params[:equipo])
  end

  def show
  end
end
