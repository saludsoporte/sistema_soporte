class OpcionAvanzadasController < ApplicationController
  def index
  end
  def new
      @opcion_av=OpcionAvanzada.new
      
  end
  def create 
    @opcion_av=OpcionAvanzada.new(params_opcion)

    if @opcion_av.save
      redirect_to opcion_path(params_opcion[:opcion_id])
    else
      render :show
    end
  end

  def edit
    @opcion_av=OpcionAvanzada.find(params[:id])
  end

  def update
    @opcion_av=OpcionAvanzada.find(params[:id])
    if @opcion_av.update(params_opcion)
      redirect_to opcion_path(params[:opcion])
    end
  end

  def destroy
    @opcion_av=OpcionAvanzada.find(params[:id])
    @catalogo=Opcion.find(@opcion_av.opcion_id)
    @opciones_rel=RelacionSolOpt.where(opcion_av_id:params[:id])
    if @opciones_rel.count>0
      @opciones_rel.destroy_all
    end

    if @opcion_av.destroy
      redirect_to opcion_path(@catalogo.id)
    end

  end
  private 
  def params_opcion
    params.require(:opcion_avanzada).permit(:nombre,:opcion_id)
  end
end
