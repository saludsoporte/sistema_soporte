class ReportesController < ApplicationController
  #before_action :authenticate_user!
  def index
    if params[:perfil_id].nil?
      @reportes=Reporte.paginate(page:params[:page],per_page:10).all.order(id: :asc)
    else      
      @perfil_id=params[:perfil_id]
      @solicitud=Asignacion.where("perfil_id=? and reasignada = false and a_reasignar=false",params[:perfil_id])
      if @solicitud.count > 0
        @sol_id=Array.new
        @arreglo_sql="("      
        @solicitud.each.with_index do |s,index|
          if index.to_i == @solicitud.length()-1
            @arreglo_sql+=s.reporte_id.to_s
          else
            @arreglo_sql+=s.reporte_id.to_s+","
          end
        end
        @arreglo_sql+=")" 
        @reportes=Reporte.paginate(page:params[:page],per_page:10).where("id in #{@arreglo_sql} ").order(id: :asc)     
      end      
    end   
  end

  def new
    @reporte=Reporte.new  
    @asignacion=Asignacion.new
    @solicitud=Solicitud.find(params[:solicitud_id])
    @solicitante=User.find(@solicitud.solicitante_id)
  end
  
  def create
    @solicitud=Solicitud.find(reporte_params[:solicitud_id])
    @repo_sol=Reporte.find_by(solicitud_id:reporte_params[:solicitud_id])
    @error=true
    if @repo_sol.nil?
      @reporte=Reporte.new(reporte_params)
      if @reporte.save      
        @estado_id=Estado.find_by(estado:"Atendiendo",tipo:"Solicitud").id    
        @solicitud.update(estado_id:@estado_id)
        @asignacion=Asignacion.new(asignacion_params)
        @asignacion.save
        @error=false
        redirect_to reporte_path(Reporte.last.id)
      end
    else
      @reporte=Reporte.new  
      @asignacion=Asignacion.new
      @solicitud=Solicitud.find(reporte_params[:solicitud_id])
      @solicitante=User.find(@solicitud.solicitante_id)
      render :new
    end
  end
  
  def edit
    @reporte=Reporte.find(params[:id])
    update
  end

  def update
    @solicitud=Solicitud.find(@reporte.solicitud_id)
    if params[:vobo]
      if params[:sol]
        @reporte.update(vobo_repo:true,estado_id:5)      
        @solicitud.update(vobo_sol:true,estado_id:8)
        redirect_to solicitud_path(params[:sol_id])
      else
        @reporte.update(vobo_repo:true,estado_id:14,fecha_entrega:Time.now.strftime("%Y-%m-%d"),hora_egreso:Time.now.strftime("%H:%M")) 
        @asignacion=Asignacion.find_by("reporte_id = ?",@reporte.id)
        @perfil=Perfil.find(@asignacion.perfil_id)
        @perfil.update(disponible:false)
        
        UserMailer.welcome_email(@solicitud.solicitante_id,@reporte.folio).deliver
        redirect_to reporte_path(params[:id])
      end      
    end
  end

  def show
    unless params[:errores].nil?          
      @errores=params[:errores]           
    end
    @r=Reporte.find(params[:id])
    @solicitante=User.find(@r.user_id)
    @solicitud=Solicitud.find(@r.solicitud_id)
    @actividades=Actividad.where("reporte_id = ?",params[:id])   
  end

  def carga_pdf
    @reporte=Reporte.find(params[:id])
    @solicitante=User.find(@reporte.user_id)
    @solicitud=Solicitud.find(@reporte.solicitud_id)
    @actividades=Actividad.where("reporte_id = ?",params[:id])   
    respond_to do |format|
      format.html { }
      format.json {} 
      format.pdf { render template: 'reportes/reporte' , pdf:'Nombre_reporte',page_size: 'letter', layout: "pdf.html"}
    end    
  end

  private
  def asignacion_params
    @perfil=Perfil.find_by(id_usuario:@solicitud.tecnico_id)
    @parametros={:reporte_id=>@reporte.id ,:perfil_id=>@perfil.id,:fecha_asignacion=>Time.now.strftime("%Y-%m-%d"),:nombre_user=>@perfil.nombre,:motivo=>"no reasignada"}
  end
  def reporte_params
    params[:reporte][:hora_ingreso]=Time.now.strftime("%H:%M") 
    params.require(:reporte).permit(:serie,:solicitud_id,:estado_id,:fecha_ingreso,:fecha_entrega,:descripcion_sencilla,:area,:direccion,:subdireccion,:departamento,:folio,:user_id,:hora_ingreso)
  end
end
