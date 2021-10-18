class ActividadsController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def show
  end

  def edit
    @actividad= Actividad.find(params[:id])  
  end

  def update    
    @actividad=Actividad.find(params[:id])
    if @actividad.update(descripcion:params[:actividad][:descripcion])      
      redirect_to reporte_path(@actividad.reporte_id)
    else
      render :edit
    end
  end

  def new
    @r=Reporte.find(params[:id])    
    @actividad=Actividad.new
  end

  def create
    @actividad=Actividad.new(actividad_params)
    if @actividad.save
      @reporte=Reporte.find(actividad_params[:reporte_id])
      @reporte.update(estado_id:4)
      redirect_to reporte_path(actividad_params[:reporte_id])
    else 
      redirect_to controller:"reportes", action:"show", id:actividad_params[:reporte_id], errores:@actividad.errors.full_messages
      
    end
  end
  private 
  def actividad_params
    params[:actividad][:hora]=Time.now.strftime("%H:%M") 
    params[:actividad][:perfil_id]=Asignacion.find_by("reporte_id = ? and reasignada= false ",params[:actividad][:reporte_id]).perfil_id
    params.require(:actividad).permit(:reporte_id,:descripcion,:fecha,:hora,:perfil_id,:tipo)
  end
end
