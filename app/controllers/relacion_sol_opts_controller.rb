class RelacionSolOptsController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def show
  end

  def edit
    logger.debug "asadas/*/*/*/*/*/*/"+params[:id].to_s
    @relacion=RelacionSolOpt.find(params[:id])  
    @num=@relacion.opcion_av_id
    @Opciones=OpcionAvanzada.where(opcion_id:params[:catalogo_id])
  end

  def destroy
    @relacion=RelacionSolOpt.find(params[:id])  
    @id=@relacion.solicitud_id
    @relacion.destroy
    redirect_to solicitud_path(@id)
  end

  def eliminar_relacion
    @relaciones=RelacionSolOpt.where(solicitud_id:params[:solicitud_id])
    @relaciones.destroy_all
    redirect_to solicitud_path(params[:solicitud_id])
  end

  def update
    @relacion=RelacionSolOpt.find(params[:id])
    if @relacion.update(relacion_sol_opt)
      redirect_to solicitud_path(@relacion.solicitud_id)
    else
      render :edit
    end
  end
  def new
    @relacion=RelacionSolOpt.new
  end

  def create
    unless params[:problema].nil?
      @problema=OpcionAvanzada.find(params[:problema])
      params[:relacion_sol_opt][:opcion_av_id]=@problema.id
      params[:relacion_sol_opt][:opcion_nombre]=@problema.nombre
    end
    @relacion=RelacionSolOpt.new(relacion_sol_opt)
    @solicitud=Solicitud.find(relacion_sol_opt[:solicitud_id].to_s)
    
    logger.debug "PROBLEMA   ***"+params[:problema].to_s

    if @relacion.save
     
      @estado_id=Estado.find_by(estado:"Abierta",tipo:"Solicitud")
      if @solicitud.update(estado_id:@estado_id.id)
        redirect_to solicitud_path(relacion_sol_opt[:solicitud_id].to_s)
      end
      
    else      
      redirect_to solicitud_path(@solicitud.id)
    end
  end


  private

  def relacion_sol_opt    
    params.require(:relacion_sol_opt).permit(:solicitud_id,:opcion_id,:opcion_nombre,:descripcion_sencilla,:opcion_av_id,:opcion_nombre)
  end
end
