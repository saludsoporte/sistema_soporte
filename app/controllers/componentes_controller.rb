class ComponentesController < ApplicationController
  def index
    @componentes=Componente.paginate(page:params[:page]).all.order(id: :asc)    
    @comp_ids="("
   
    @componentes.each.with_index do |c,index|
      if index.to_i == @componentes.length()-1
        @comp_ids+=c.id.to_s
      else
        @comp_ids+=c.id.to_s+","
      end
    end
    @comp_ids+=")"
    @relacionesCarac=RelacionCaracteristica.where("componente_id in #{@comp_ids} ")
  end

  def show
    @componente=Componente.find(params[:id])
    @relacion_com=RelacionCaracteristica.where("componente_id=?",params[:id])
  end

  def new
    @componente=Componente.new
  end

  def carga_conjunto
    logger.debug "************ "+@relacion.to_s
    @relacion=Array.new
    @serial=CompSerial.find(params[:existencia])    
    
    @caracteristicas=RelacionCaracteristica.where("componente_id=? and id in (#{@serial.conjunto})",params[:comp])
    @caracteristicas.each do |ca|
       @relacion.push(caracteristica:ca.caracteristica.nombre,valor:ca.valor_caracteristica)
    end   
    respond_to do |format|
      format.js { render :json => @relacion }
    end
  end

  def create
    @modelo=Componente.find_by("modelo ilike ('%#{params[:componente][:modelo]}%')")
    logger.debug"***************/////////"+params[:componente][:modelo].to_s
    logger.debug"***************/////////"+@modelo.nil?.to_s
    if @modelo.nil?
      @componente=Componente.new(params_comp)
      if @componente.saveadasdas
        @comp=Tipocomp.find(componente.tipocomp_id)
        if @comp.nombre == 'Ram'
          @carac=Caracteristica.find_by("nombre = 'Capacidad de Memoria'")
          @tipocamp=Caracteristica.find_by("nombre = 'Tipo de Memoria'")
          @capacidad=params[:ram_cp]+params[:mem_size]
          @tipo_mem=params[:tipo_mem]    
          @caracteristicas=RelacionCaracteristica.new(componente_id:@componente.id,caracteristica_id:@carac.id,valor_caracteristica:@capacidad)
          @caracteristicas.save
          @caracteristicas2=RelacionCaracteristica.new(componente_id:@componente.id,caracteristica_id:@tipocamp.id,valor_caracteristica:@tipo_mem)
          @caracteristicas2.save   
        end

        if @comp.nombre == 'Disco Duro'
          @carac=Caracteristica.find_by("nombre = 'Capacidad de Memoria'")
          @carac2=Caracteristica.find_by("nombre = 'Tipo de Disco Duro'")
          @capacidad=params[:hdd_cap]+params[:hdd_mem_size]
          @tipo=params[:tipoHDD]
          @caracteristicas=RelacionCaracteristica.find_by("  componente_id=? and caracteristica_id=? and valor_caracteristica=?",@componente.id,@carac.id,@capacidad)
          @caracteristicas2=RelacionCaracteristica.find_by(" componente_id=? and caracteristica_id=? and valor_caracteristica=?",@componente.id,@carac2.id,@tipo)
          @caracteristicas.save
          @caracteristicas2.save 
        end

        if @comp.nombre == 'Procesador'
          @carac=Caracteristica.find_by("nombre = 'Frecuencia'")
          @frecuencia=params[:frecuencia]+params[:frenc_tipo]

          @relacion=RelacionCaracteristica.find_by("componente_id=? and caracteristica_id=? and valor_caracteristica=?",@componente.id,@carac.id,@frecuencia)
          @relacion.save
        end
        
        redirect_to new_comp_serial_path(comp_id:@componente.id)
      else
        render :new
      end
    else
      render :new
    end
  end
  def edit
    @componente=Componente.find(params[:id])
    @tipos=Tipocomp.all
  end
  def update
    @componente=Componente.find(params[:id])
    if params[:del]
      nueva_cant=@componente.cantidad - params[:componente][:cantidad].to_i
      logger.debug "*/*/*/*/*/*/*/* "+nueva_cant.to_s
      @componente.update(cantidad:nueva_cant)
      redirect_to componentes_path
    elsif @componente.update(params_comp)
      redirect_to componentes_path
    else
      if params[:del]
        redirect componentes_path
      else
      render :edit
      end
    end
  end

  def destroy 
    @relacion_equipo=RelacionComponente.where("componente_id=?",params[:id])
    #@relacion_carac=RelacionCaracteristicas.where("componente_id=?",params[:id])
    @componente=Componente.find(params[:id])
    @relacion_equipo.destroy_all and @componente.destroy #and @relacion_carac.destroy_all
    redirect_to componentes_path
  end

  private 
  def params_comp
    params.require(:componente).permit(:tipocomp_id,:modelo,:marca)
  end
end
