class OpcionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @option=Opcion.all
    @option_new=Opcion.new
  end

  def new
    @option=Opcion.new
  end
  def create
    @option=Opcion.new(opcion_params) 
    logger.debug "*/*/*/*/*/*/*/*"
    if @option.save
      redirect_to opcions_path
    else
      render :new
    end
  end

  def show
    @options=Opcion.find(params[:id])    
    @opciones_av=OpcionAvanzada.where("opcion_id=?",@options.id)
    @opcion_av=OpcionAvanzada.new
  end

  def destroy
    @relacion=RelacionSolOpt.where(opcion_id:params[:id])
    logger.debug "conteo de relaciones "+@relacion.count.to_s
    if @relacion.count > 0
      @relacion.destroy_all
    end
    @opciones_av=OpcionAvanzada.where(opcion_id:params[:id])
    if @opciones_av.count >0
      @opciones_av.destroy_all
    end

    @options=Opcion.find(params[:id])

    if @options.destroy
     redirect_to opcions_path
    else
      render :index
    end
  end

  def edit
    @option=Opcion.find(params[:id])
  end

  def update
    @option=Opcion.find(params[:id])
    if @option.update(opcion_params)
      redirect_to opcions_path
    else
      render :edit
    end
  end

  def opcion_params
    params.require(:opcion).permit(:opcion,:tipo)
  end
end
