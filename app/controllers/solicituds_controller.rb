class SolicitudsController < ApplicationController
  before_action :authenticate_user!
  def index      
    logger.debug "******************"+params[:exist].to_s
    if params[:exist].nil?
      @exist=true
    else
      @exist=false
    end

    if !params[:user_id].nil?
      @perfil=Perfil.find_by("id_usuario=?",current_user.id)
      @lista=Solicitud.paginate(page:params[:page]).where("solicitante_id=?",params[:user_id])            
    elsif !params[:solicitante].nil?
      @perfil=Perfil.find_by("id_usuario=?",current_user.id)
      @lista=Solicitud.paginate(page:params[:page]).where("nombre_user ilike ('%#{params[:solicitante]}%')")            
    else
      if params[:id_perfil].nil?
        @lista=Solicitud.paginate(page:params[:page]).all.order('id DESC')
        @general=true
      else
        @general=false      
        if current_user.rol_id==1
          @perfil=Perfil.find(params[:id_perfil])
          @lista=Solicitud.paginate(page:params[:page]).where("perfil_id=? or tecnico_id=?",@perfil.id,@perfil.id_usuario).order("id desc")
        else
          @lista=Solicitud.paginate(page:params[:page]).where("perfil_id=? or tecnico_id=?",params[:id_perfil],current_user.id).order("id desc")
        end      
      end 
    end
  end

  def buscar_por_nombre
    redirect_to solicituds_path(solicitante:params[:user])
  end 


  def new
    @solicitud=Solicitud.new
    @estados=Estado.find_by(estado:"Inicial",tipo:"Solicitud")
    @tecnicos=Perfil.where("id_rol in (4,1)")
    @usuarios=User.all.order(id: :asc)
    
    logger.debug "*/********************"+@array_usuarios.to_s
  end

  def buscar_user
    @equipo=Equipo.find_by(user_id:params[:id])
    if @equipo.nil?
      @equipo=false
    end
    respond_to do |format|
      format.js { render :json => @equipo }
    end
  end

  def create    
    @tecnicos=Perfil.where("id_rol in (4,1)")
    if current_user.rol_id == 3 
      asignaTecnico
    elsif current_user.rol_id==4
      params[:solicitud][:tecnico_id]=current_user.id
    end
    @solicitud=Solicitud.new(solicitud_params)
    if @solicitud.save
     redirect_to solicitud_path(@solicitud.id)
    else     
      @estados=Estado.find_by(estado:"Inicial",tipo:"Solicitud")
      
      render :new
 
    end
  end

  def asignaTecnico
    @tecnicos=Perfil.where("id_rol in (4,1)")    
    @tecnicos.each  do |tec |
      if tec.disponible ==  false
        tec.update(disponible:true)
        params[:solicitud][:tecnico_id]=tec.id_usuario
        break
      end
    end
  end
  def tec_up    
   @solicitud=Solicitud.find(params[:solicitud][:id])
   @solicitud.update(tecnico_id:params[:solicitud][:tecnico_id])
   redirect_to solicitud_path(params[:solicitud][:id])
  end
  def sol    
    @solicitud=Solicitud.find(params[:solicitud][:id])
    @user=User.find(params[:solicitud][:solicitante_id])
    @solicitud.update(nombre_user:@user.nombre_personal,solicitante_id:@user.id)
    redirect_to solicitud_path(params[:solicitud][:id])
  end
  def cancel_sol
    @solicitud=Solicitud.find(params[:id])
    @edo=Estado.find_by("tipo= ? and estado = ? ","Solicitud","Cancelada")
    @solicitud.update(estado_id:@edo.id)
    UserMailer.solicitud_cancelada(@solicitud.solicitante_id).deliver
    
    redirect_to solicitud_path(@solicitud.id)
  end

  def vobo_admin 
    @solicitud=Solicitud.find(params[:solicitud_id])
    @reporte=Reporte.find_by("solicitud_id=?",params[:solicitud_id])
    @reporte.update(estado_id:5)
    @solicitud.update(vobo_sol:true,estado_id:8,fecha_termino:Time.now.strftime("%Y-%m-%d"))
    redirect_to solicituds_path
  end

  def edit
    @solicitud=Solicitud.find(params[:id])
    @solicitantes=User.all
    @tecnicos=Perfil.where("id_rol in (1,4)")
=begin
    if !params[:edit].nil?
      @solicitud=Solicitud.find(params[:id])
    else
    
    @relaciones=RelacionSolOpt.where(solicitud_id:params[:id])
    @perfil_id=current_user.perfil_id
    @solicitud=Solicitud.find(params[:id])
    if @relaciones.count >0   
      logger.debug "/////////// edit "+params[:modal].to_s      
      if params[:modal].nil?        
        @modal=false
          logger.debug "///////// modal"    
        update  
      else  
        @rol_id=Rol.find_by(nombre:"Tecnico")     
      end
    else
        
      if params[:general]
        redirect_to solicituds_path(exist:false)
      else
        logger.debug "relaciones en 0"
        redirect_to solicituds_path(id_perfil:params[:perfil_id],exist:false)
      end
    end
    end
=end  
  end

  def update
    #@estado_id=Estado.find_by(estado:"Abierta",tipo:"Solicitud")
    @solicitud=Solicitud.find(params[:id])
    if  @solicitud.update(solicitud_params)
      redirect_to @solicitud
    else
      render :edit
    end
  end
  def show
    @solicitud=Solicitud.find(params[:id])
    @relacion=RelacionSolOpt.new
    @relaciones=RelacionSolOpt.where(solicitud_id:params[:id])    
    @ids_catalogo=Opcion.all
    @solicitantes=User.all.order(id: :asc)
  end

  def carga_relacion
    logger.debug "Carga relacion ******"+params[:id]
    @opciones_avanzadas=OpcionAvanzada.where("opcion_id = ? ",params[:id])
    respond_to do |format|
      format.js { render :json => @opciones_avanzadas   }
    end
  end

  private 
   def solicitud_params    
    if params[:solicitud][:solicitante_id].to_i > 0
      params[:solicitud][:nombre_user]=User.find(params[:solicitud][:solicitante_id].to_i).nombre_personal
    end
    
    
    logger.debug "////////////////////////"+params[:solicitud][:nombre_user].to_s
    params.require(:solicitud).permit(:serie,:tecnico_id,:solicitante_id,:perfil_id,:nombre_user,:fecha_inicio,:fecha_termino,:estado_id,:"descripcion_sencilla",:usuario_captura)
   end
  
end
