class RelacionCaracteristicasController < ApplicationController
  def index
  end

  def show
    
  end

  def cargar_conjuntos    
    @conjunto=CompSerial.find(params[:conjunto])
    @relacion=RelacionCaracteristica.where("componente_id = ? and id in (#{@conjunto.conjunto})",params[:compo_id])           
  end

  def new_cargar_conjuntos    
    @conjunto=CompSerial.find(params[:conjunto_2])
    @relacion=RelacionCaracteristica.where("componente_id = ? and id in (#{@conjunto.conjunto})",params[:compo_id])           
    redirect_to new_relacion_caracteristica_path(comp_id:params[:compo_id],serial:@conjunto.id)
  end

  def edit
    @relacion=RelacionCaracteristica.find(params[:id])
  end

  def update
    @relacion=RelacionCaracteristica.find(params[:id])
    @relacion.update(params_comp)
    redirect_to new_relacion_caracteristica_path(comp_id:@relacion.componente_id)
  end

  def new
    @componente=Componente.find(params[:comp_id])
    @relacion=RelacionCaracteristica.new
    @caracteristicas=RelacionCaracteristica.where("componente_id=?",@componente.id)
    
  end
  def carga_conjunto
    logger.debug "************ "+@relacion.to_s
    @relacion=Array.new
    @relacion=false
    
    if params[:conjunto]=='null'
      @caracteristicas=RelacionCaracteristica.where("componente_id=?",params[:compo_id])
    else
      @caracteristicas=RelacionCaracteristica.where("componente_id=? and conjunto=?",params[:compo_id],params[:conjunto])
    end
    unless @caracteristicas.nil?
      if @caracteristicas.count==0
        @relacion=true
      elsif params[:conjunto]!='null'   
        @relacion=Array.new     
        @caracteristicas.each do |ca|
          @relacion.push(caracteristica:ca.caracteristica.nombre,valor:ca.valor_caracteristica)
        end 
      end   
    end
    
    respond_to do |format|
      format.js { render :json => @relacion }
    end
  end
  def destroy 
    @relacion=RelacionCaracteristica.find(params[:id])
    @comp_id=@relacion.componente_id
    @relacion.destroy
    redirect_to componente_path(@comp_id)
  end

  def create
    @carac=RelacionCaracteristica.find_by("componente_id=? and caracteristica_id=? and valor_caracteristica=?",params[:relacion_caracteristica][:componente_id],params[:relacion_caracteristica][:caracteristica_id],params[:relacion_caracteristica][:valor_caracteristica])
    logger.debug "*************** "+params[:relacion_caracteristica][:componente_id].to_s
    logger.debug "*************** "+params[:relacion_caracteristica][:caracteristica_id].to_s
    logger.debug "*************** "+params[:relacion_caracteristica][:valor_caracteristica].to_s
    
    if @carac.nil?
      @caracteristicas=RelacionCaracteristica.new(params_comp)       
      if @caracteristicas.save
        @componente=Componente.find(@caracteristicas.componente_id)
        @caracs=RelacionCaracteristica.where("componente_id=?",@componente.id)
        @ids=""
        @caracs.each.with_index do |c,i|
          if @caracs.length-1 == i
            @ids+=c.id.to_s
          else
            @ids+=c.id.to_s+","
          end          
        end
        if params[:serial].nil?        
          @seriales=CompSerial.where("componente_id=?",@componente.id)
          @seriales.update_all(conjunto:@ids)
        else
            @serial=CompSerial.find(params[:serial])
            @serial.update(conjunto:@ids)
        end
        redirect_to new_relacion_caracteristica_path(comp_id:params_comp[:componente_id])
      else
        
        @relacion=RelacionCaracteristica.new
        if params[:relacion_caracteristica][:caracteristica_id].nil?
          logger.debug "/*/*/*/*/**/*/54454"  
          @error=1
        end
        
        if params[:relacion_caracteristica][:valor_caracteristica]==""
          @error=2
        end

        if params[:relacion_caracteristica][:caracteristica_id].nil? && params[:relacion_caracteristica][:valor_caracteristica]==""
          @error=3
        end

        params[:relacion_caracteristica][:valor_caracteristica].to_s
        redirect_to new_relacion_caracteristica_path(comp_id:params_comp[:componente_id],error:@error)
      end      
    else      
      @relacion=RelacionCaracteristica.new
      redirect_to new_relacion_caracteristica_path(comp_id:params_comp[:componente_id],alert:"Ya existe")
    end
  end

  private 
  def params_comp   
    params.require(:relacion_caracteristica).permit(:componente_id,:caracteristica_id,:valor_caracteristica)
  end
end
