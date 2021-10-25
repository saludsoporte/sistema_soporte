class CompSerialsController < ApplicationController
  def index
    #@comp_seriales=CompSerial.where(tipocomp_id:params[:comp_id])
    @comp_seriales=CompSerial.paginate(page:params[:page]).where("componente_id=?",params[:comp_id])
    logger.debug "***********************  "+@comp_seriales.count.to_s
  end
  def new
    logger.debug "33#####################333"
    @componente=Componente.find(params[:comp_id])
    @caracteristicas=RelacionCaracteristica.where("componente_id=?",params[:comp_id])
    @comp_serie=CompSerial.new
    @seriales=CompSerial.where("componente_id=?",params[:comp_id])
  end

  def show 
    @serial=CompSerial.find(params[:id])    
    @componente=Componente.find(@serial.componente_id)
  end

  def asignar_equipo
    logger.debug "************"+params[:comp].to_s
    unless params[:equipos].nil?      
      @serie=CompSerial.find(params[:id])   
      @relacion=RelacionComponente.new(componente_id:params[:comp],equipo_id:params[:equipos],comp_serial_id:@serie.id)        
        if @relacion.save             
          @serial=CompSerial.find(@relacion.comp_serial_id)
          @bollean=false
          @serial.update(disponible:@bollean)          
          @inventario=Inventario.find_by(tipocomp_id:@relacion.componente.tipocomp_id)
          @inventario.update(disponibles:@inventario.disponibles-1)
          redirect_to inventarios_path
        else
          render :asignar_equipo
        end       
    end
  end 
  def carga_conjunto
    logger.debug "************ "+@relacion.to_s
    @relacion=Array.new
    @caracteristicas=RelacionCaracteristica.where("componente_id=? and conjunto=?",params[:compo_id],params[:conjunto])
    @caracteristicas.each do |ca|
       @relacion.push(caracteristica:ca.caracteristica.nombre,valor:ca.valor_caracteristica)
    end   
    respond_to do |format|
      format.js { render :json => @relacion }
    end
  end

  def buscar_eq
    @equipo=Equipo.find(params[:id])
    @arr=Array.new
    if @equipo.nil? || @equipo.user_id.nil?
      @arr=false
    else
      @arr.push(serie:@equipo.no_serie,activo_fijo:@equipo.activo_fijo,
      tipo:@equipo.tipo,piso:@equipo.piso,user:User.find(@equipo.user_id).nombre_personal)
    end
    respond_to do |format|
      format.js { render :json => @arr }
    end
  end


  def create
    @componente=Componente.find(params[:comp_id])
    
    @seriales=CompSerial.where("no_serie = ? and no_activo_fijo=?",params_serie[:no_serie],params_serie[:no_activo_fijo])     
    if @seriales.count==0
      @comp_serie=@componente.comp_serials.create(params_serie)
      if @comp_serie.save
        @inventario_f=Inventario.find_by("tipocomp_id=?",@componente.tipocomp_id)
        if @inventario_f.nil?  
          @inventario=Inventario.new(          
            tipocomp_id:@componente.tipocomp_id,
            cantidad:1,
            disponibles:1          
          )
          @inventario.save
        else
          logger.debug "****************** con inventario"
          @cantidad=@inventario_f.cantidad
          @inventario_f.update(cantidad:@cantidad+1,disponibles:@inventario_f.disponibles+1)
        end       
        redirect_to new_comp_serial_path(comp_id:params[:comp_id])       
      else
        @error=""             
        if params_serie[:no_serie]==""
          @error=1
        end
          
        if params_serie[:no_activo_fijo]==""
          @error=2
        end
        
        if params_serie[:conjunto]=="" || params_serie[:conjunto].nil?
          @error=4
        end

        if params_serie[:no_serie]=="" && params_serie[:no_activo_fijo]=="" && (params_serie[:conjunto]=="" || params_serie[:conjunto].nil?)
          @error=3
        end


        logger.debug "/*/*/*/*/* "+@error.to_s
        redirect_to new_comp_serial_path(comp_id:params[:comp_id],error:@error)       
      end     
    else
      logger.debug "///////////////////// ya existe"
      @error=5
      redirect_to new_comp_serial_path(comp_id:params[:comp_id],error:@error)       
    end
  end

  def destroy
    @comp_serial=CompSerial.find(params[:id])    
    @inventario_f=Inventario.find_by("tipocomp_id=?",@comp_serial.tipocomp_id)
    @relacion=RelacionComponente.find_by("comp_serial_id=?",@comp_serial.id)    
    unless @relacion.nil?        
      @relacion.destroy
    end 
    @cantidad=@inventario_f.cantidad
    @disponibles=@inventario_f.disponibles    
    if @disponibles -1 < 0
      @disponibles=0
    else
      @disponibles=@disponibles-1
    end
    @inventario_f.update(cantidad:@cantidad-1,disponibles:@disponibles)     
    @comp_serial.destroy
    
    redirect_to inventarios_path(tipocomp_invt:@inventario_f.tipocomp_id)
  end
  private 
  
  def params_serie
    params[:comp_serial][:tipocomp_id]=@componente.tipocomp_id
    params[:comp_serial][:conjunto]=params[:conjunto]
    params.require(:comp_serial).permit(:no_serie,:no_activo_fijo,:tipocomp_id,:conjunto)
  end

end
