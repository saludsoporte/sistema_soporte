class LogEquiposController < ApplicationController
  def index
    @logs=LogEquipo.all
  end

  def show
  end
end
