class EstadosController < ApplicationController
  before_action :authenticate_user!
  def index
    @estados=Estado.all
  end

  def new
    @estado=Estado.new
  end

  def create
    
    @estado=Estado.new(estado_params)
    logger.debug "************* "+estado_params.to_s
    
    if @estado.save
      redirect_to estados_path
    else
      logger.debug "/*/*/*/*/*/***/*/"
       @estados=Estado.all
      render :index
    end
  end

  def edit
    @estado=Estado.find(params[:id])  
  end

  def update

    @estado=Estado.find(params[:id])
    if @estado.update(estado_params)
      redirect_to estados_path
    else
      render :edit
    end
  end

  def destroy
    #@solicitud=Solicitud.where(estado_id:params[:id])
    #@reportes=Reporte.where(estado_id:params[:id])
    #@peticiones=Peticon.where(Estado_id:params[:id])
    #if @solicitud.count > 0
     # @solicitud.update_all(estado_id:"0")
    #end
    @estado=Estado.find(params[:id])
    if @estado.destroy
      redirect_to estados_path
    else 
      render :index
    end
  end

  private

  def estado_params
    
    params[:estado][:tipo]=params[:tipo]
    params.require(:estado).permit(:estado,:descripcion,:tipo)
  end
end
