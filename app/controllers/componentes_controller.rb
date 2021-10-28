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
    @caracteristicas=RelacionCaracteristica.where("componente_id=? and id in (?)",params[:comp],@serial.conjunto)
    @caracteristicas.each do |ca|
       @relacion.push(caracteristica:ca.caracteristica.nombre,valor:ca.valor_caracteristica)
    end   
    respond_to do |format|
      format.js { render :json => @relacion }
    end
  end

  def create
    @componente=Componente.new(params_comp)
    if @componente.save
      redirect_to new_comp_serial_path(comp_id:@componente.id)
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
