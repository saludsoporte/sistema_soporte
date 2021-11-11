class RelacionComponentesController < ApplicationController
  def index

  end

  def show
  end

  def new
    @equipo=Equipo.find(params[:equipo_id])
    #@Componentes=Componente.joins("inner JOIN Relacion_Componente ON RelacionComponente.componente_id != Componente.id")      
    @relacionesCom=RelacionComponente.where("equipo_id=?",params[:equipo_id])
    @relaciones=RelacionComponente.new
    @tipocomp=Tipocomp.all
  end
  def carga_componente
    if params[:id]!=""
      @componentes=Componente.where("tipocomp_id=?",params[:id])
      logger.debug "Carga relacion ******"+params[:id]
      respond_to do |format|
        format.js { render :json => @componentes  }
      end
    else
      respond_to do |format|
        format.js { render :json => nil   }
      end  
    end
  
  end
  
  def carga_caracteristicas
    if params[:compo_id]!="" && params[:compo_id]!="null"
      
      @relacion=Array.new
      @serial=CompSerial.find(params[:id])
      logger.debug "***********iiiiiiiiiiiiiiiii********** /////" +@serial.componente_id.to_s
      logger.debug "***********iiiiiiiiiiiiiiiii********** /////" +@serial.conjunto.to_s
      @caracteristicas=RelacionCaracteristica.where("componente_id=? and conjunto=?",@serial.componente_id,@serial.conjunto)
      @caracteristicas.each do |ca|
        @relacion.push(caracteristica:ca.caracteristica.nombre,valor:ca.valor_caracteristica)
      end
      logger.debug "***********iiiiiiiiiiiiiiiii********** /////"  
      respond_to do |format|
        format.js { render :json => @relacion }
      end  
    else
      logger.debug "Carga caracteristicas ******"+params[:id]
      respond_to do |format|
      format.js { render :json => nil   }
      end  
    end    
  end

  def carga_serial
    if params[:id]!="" 
      
      #@caracteristicas=RelacionCaracteristica.where("componente_id=?",params[:compo_id])
      @relacion=Array.new
      #@caracteristicas.each do |c|
      #  @relacion.push(caracteristica:c.caracteristica.nombre,valor:c.valor_caracteristica)
      #end 
      @seriales=CompSerial.where("componente_id=? and disponible=true ",params[:compo_id])
      @seriales.each do |s|
        @relacion.push(id:s.id,serial:s.no_serie,activo_fijo:s.no_activo_fijo)
      end


      #@relacion.push(caracteristica:"disponible",valor:@disponible)
      respond_to do |format|
        format.js { render :json => @relacion }
      end  
    else
      logger.debug "Carga caracteristicas ******"+params[:id]
      respond_to do |format|
      format.js { render :json => nil   }
      end  
    end    
  end
  def create    
    @comp=CompSerial.find(params[:serial_id])
    @relacion=RelacionComponente.new(
      componente_id:params[:componente_id],
      equipo_id:params[:equipo],
      comp_serial_id:@comp.id
    )    
    if @relacion.save
      @comp.update(disponible:false)
      @inventario_f=Inventario.find_by("tipocomp_id=?",@relacion.componente.tipocomp_id) 
      @cantidad=@inventario_f.disponibles
      @inventario_f.update(disponibles:@cantidad-1) 
      redirect_to new_relacion_componente_path(equipo_id:params[:equipo])
    else
      render :new
    end

  end
  def edit   
    @relacion=RelacionComponente.find(params[:id])    
    @equipo=Equipo.find(@relacion.equipo_id)
    @componente=Componente.where("tipocomp_id=?",@relacion.componente.tipocomp.id)    
    @caracteristicas=RelacionCaracteristica.where("componente_id=?",@relacion.componente.id)
    @rel=Array.new
    @caracteristicas.each do |c|
      @rel.push(caracteristica:c.caracteristica.nombre,valor:c.valor_caracteristica)
    end
    @edit=true
  end

  def destroy 
    @relacion=RelacionComponente.find(params[:id])
    @comp=CompSerial.find(@relacion.comp_serial_id)
    @comp.update(disponible:true)
    @tipo=Tipocomp.find(@relacion.componente.tipocomp_id)
    @inventario_f=Inventario.find_by("tipocomp_id=?",@tipo.id)
    @disponible=@inventario_f.disponibles
    @inventario_f.update(disponibles:@disponible+1)
    @relacion.destroy
    redirect_to equipo_path(@relacion.equipo_id)
  end
end
