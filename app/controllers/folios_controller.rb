class FoliosController < ApplicationController
  def index
    @reporte=Reporte.new
    if params[:error]
      @error=true
    end

    unless params[:reporte_id].nil?
      @error=false
      @r=Reporte.find(params[:reporte_id])
      @solicitante=User.find(@r.user_id)
      @solicitud=Solicitud.find(@r.solicitud_id)
      @actividades=Actividad.where(reporte_id:@r.id)
      if @r.vobo_repo && @solicitud.vobo_sol        
        @vobo=true
      else
        @vobo = false
      end
    end
  end

  def edit    
    @reporte=Reporte.find(params[:id])
    @reporte.update(vobo_repo:true,estado_id:5)
    @solicitud=Solicitud.find(params[:sol_id])
    @solicitud.update(vobo_sol:true,estado_id:8,fecha_termino:Time.now.strftime("%Y-%m-%d"))
    redirect_to folios_path(reporte_id:@reporte.id)    
  end
  
  def reporte   
    if !params[:reporte][:folio].nil?      
      @reporte=Reporte.find_by(folio:params[:reporte][:folio])

      if @reporte.nil?            
        redirect_to folios_path(error:true)
      else    
        logger.debug "antes del mailer **************"
       
        redirect_to folios_path(reporte_id:@reporte.id)
      end    
    else      
      redirect_to folios_path(error:true)
    end
  end
end
