class RolsController < ApplicationController
  before_action :authenticate_user!
  def index
    @rols=Rol.all.order("id asc")
  end

  def show
    @rol=Rol.find(params[:id])
  end

  def edit
    @rol=Rol.find(params[:id])
  end

  def update
    @rol=Rol.find(params[:id])
    
    if @rol.update(rol_params)
        redirect_to @rol
    else
        logger.debug "**********************"
        redirect_to edit_rol_path(@rol.id)
    end 
  end

  def new
    @permisos=Permiso.all
    @rols=Rol.all
    @rol=Rol.new
  end
  def create
    @rol = Rol.new(rol_params)
    if @rol.save
        redirect_to @rol
    else
        render :new
    end
  end

  def destroy
    @relacion= RelacionPerRol.where(rol_id:params[:id])
    @rol=Rol.find(params[:id])
    @band_del=false
    if @relacion.count > 0
        if @relacion.destroy_all             
          if @rol.destroy
            @band_del=true
          end
        end
    else        
      if @rol.destroy
        @band_del=true
      end
    end
    if @band_del      
      redirect_to rols_path
    else
      render :index
    end
    
  end
  private 
  
  def rol_params
      params.require(:rol).permit(:rol,:nombre,:descripcion)

  end
end
