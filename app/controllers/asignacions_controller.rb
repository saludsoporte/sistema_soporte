class AsignacionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @asignaciones=Asignacion.where(" a_reasignar = true").order(reporte_id: :asc )
  end

  def show
  end

  def edit
    logger.debug "/*/*/*/**/*/* entra"
    @asignacion=Asignacion.find(params[:id])
    if !params[:rechazo].nil?
      @asignacion.update(reasignada:false,a_reasignar:false)
    end
  end
  def update
    @edo=Estado.find_by(estado:'Espera',tipo:"Reportes")
    if params[:bandera]
      @asignacion=Asignacion.find(params[:id])
      logger.debug "323232323232323 333330000000 "+params[:asignacion][:motivo].to_s
      if @asignacion.update(a_reasignar:true,motivo:params[:asignacion][:motivo])
        @reporte=Reporte.find(@asignacion.reporte_id)
        @reporte.update(estado_id:@edo.id)
        redirect_to reportes_path(perfil_id:params[:perfil_id])
      else
        render :edit
      end
    end
    
  end
  def new
    logger.debug "/*/*/*/*/*/*/"+@asignacion_id.to_s
    @asignacion=Asignacion.new
    @tecnicos=Perfil.where("id_rol in (4,1)") 
   
  end
  def create
    logger.debug "/*/*/*/*/*"+params[:asignacion_id].to_s
    @reporte=Reporte.find(params[:asignacion][:reporte_id])
    @perfil=Perfil.find(params[:asignacion][:perfil_id])
    @asig_update=Asignacion.find(params[:asignacion_id])
    @asignacion=Asignacion.new(asignacion_params)
    if @asignacion.save
      @solicitud=Solicitud.find(Reporte.find(@asignacion.reporte_id).solicitud_id)
      @solicitud.update(tecnico_id:Perfil.find(@asignacion.perfil_id).id_usuario)
      @asig_update.update(reasignada:true,a_reasignar:false)
      @edo=Estado.find_by(estado:'Pendiente',tipo:"Reportes")
      @reporte.update(estado_id:@edo.id)
      redirect_to asignacions_path    
    else
      render :new
    end
    
  end

  private 
  def asignacion_params
    @perfil=Perfil.find(params[:asignacion][:perfil_id])
    @parametros={:reporte_id=>params[:asignacion][:reporte_id] ,:perfil_id=>params[:asignacion][:perfil_id],:fecha_asignacion=>Time.now.strftime("%Y-%m-%d"),:nombre_user=>@perfil.nombre,:motivo=>"no reasignada"}
  end
    
end
