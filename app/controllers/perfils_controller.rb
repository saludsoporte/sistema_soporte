class PerfilsController < ApplicationController
  before_action :authenticate_user!
  def index
    @perfil=Perfil.find_by(id_usuario:current_user.id)
    if @perfil.nil?
      redirect_to new_perfil_path
    elsif @perfil.id_rol != 1
      redirect_to perfil_path(Perfil.find_by(id_usuario:current_user.id).id)
    else
      @perfil=Perfil.where("id_usuario != ? ",current_user.id)
    end

  end
  def new
    @perfil= Perfil.new
    
  end
  
  def carga_relacion    
    if params[:id] == "-1"
      @relacion=RelacionPerRol.where("rol_id = ?",Perfil.find_by(id_usuario:current_user.id).id_rol)
    else
      @relacion=RelacionPerRol.where("rol_id = ?",params[:id])
    end    
    @rel_permisos = Array(nil)
    @relacion.each do |i|
      @rel_permisos.append(i.permiso)
    end

    respond_to do |format|
      format.js { render :json => @rel_permisos }
    end
  end
 
  def create
    @pid=Perfil.find_by(id_usuario:perfil_params[:id_usuario])
   
    if @pid.nil?
      @perfil=Perfil.new(perfil_params)
     if @perfil.save
        redirect_to @perfil
     else
        render :new
     end    
    end
  end

  def show    
    @perfil=Perfil.find_by(id_usuario: current_user.id)
    @equipo=Equipo.find_by(user_id:current_user.id)
    @user=User.find(@perfil.id_usuario) 
    if @perfil.nil?                
      redirect_to new_perfil_url
    end
  end
  def cargar_tabla
    logger.debug "**********************"
    @data=Array.new
    @perfil=Perfil.find(params[:id_p])
    @user=User.find(@perfil.id_usuario)    

    @data.push(rol:@user.rol,username:@user.username,nombre_personal:@user.nombre_personal,area:@user.area_nombre,
    direccion:@user.direccion_nombre,subdireccion:@user.subdireccion_nombre,departamento:@user.departamento_nombre,
    email:@user.email)
    
    if params[:screen].to_i>500
      @data.push(screen:false)      
    else
      @data.push(screen:true)      
    end

    respond_to do |format|
      format.js { render :json =>  @data }
    end
  end

  private

  def perfil_params
    params.require(:perfil).permit(:id_usuario,:id_rol)
  end
end
