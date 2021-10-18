class RelacionPerRolsController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def edit
  end
  
  def new
    @rol=Rol.find(params[:id])
    @relacion=RelacionPerRol.new
  end

  def show
    @rol=Rol.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

=begin
Obtiene el id del rol, que es la llave que indentifica el paquete de relaciones
de ahi saca la lista de relaciones que contiene el id del permiso que se va a buscar,
si encuentra una relacion que ya exista, su count sera mayor a 0 y se redireccionara 
a la misma ruta pero con una bandera levantada, que avisara al usuario que el permiso ya esta
en la relacion. Si no , continuara el proceso de creación normal
=end
  def create
    @rol=Rol.find(relacion_params[:rol_id])
    @existe=false
    if relacion_params[:permiso_id].to_i > 0
      logger.debug "*******************************************"
      @permiso=RelacionPerRol.where("rol_id= ? and permiso_id=? ",@rol.id,relacion_params[:permiso_id])
      if @permiso.count > 0
        logger.debug"***********------------------------------********************"
        @existe = true
      end
    end
   
    if !@existe
      @relacion = RelacionPerRol.new(relacion_params)
      @bandera=false
      if @relacion.save
        redirect_to new_relacion_per_rol_path(:id => relacion_params[:rol_id])
      else     
        render :new      
      end
    else
      logger.debug "++++++++++++++++++++++++++++"
     # @relacion = RelacionPerRol.new(relacion_params)
      #@existe = true
      #render :new
      redirect_to new_relacion_per_rol_path(:id => relacion_params[:rol_id],:error=>true)
    end
  end
  
   
  def destroy
    logger.debug "********************destroy"
    @relacion= RelacionPerRol.find(params[:id])
    @rol=Rol.find(@relacion.rol_id)
    if @relacion.destroy     
      redirect_to relacion_per_rol_path(@rol.id)
    else
      render :show
    end
    
  end

  private 
  def relacion_params
    params.require(:relacion_per_rol).permit(:permiso_id,:rol_id)
  end

end
