class InventariosController < ApplicationController
  def cargar_tabla
    @pantalla=params[:pantalla]
    logger.debug "**********************"+@pantalla.to_s
    index
    render :index
  end
  def index
    @id_Equipo=Tipocomp.find_by("nombre = 'Equipo de Computo'")
    @id_server=Tipocomp.find_by("nombre = 'Servidor'")
    @inventario=Inventario.find_by("tipocomp_id=?",params[:tipocomp_invt])    
    @marcas=Componente.select(:marca).distinct   
    @serie=params[:serie]
    @marca=params[:marca]  
    @activo=params[:activo]
    @activo_eq=params[:activo_eq]
    @serie_eq=params[:serie_eq]
    @tipocomp_invt=params[:tipocomp_invt]      
    @disponible=params[:disponible]
    @consulta=""

    if params[:tipocomp_invt].to_i==@id_Equipo.id || params[:tipocomp_invt]== @id_server.id
      logger.debug "**********************///////////////////////////"      
      @consulta=""

      unless params[:user_select].nil?
        @usuario=User.find(params[:user_select])    
        @consulta+=" user_id = "+@usuario.id.to_s+" and "
      end

      @consulta+=" tipocomp_id="+params[:tipocomp_invt]

      if  @disponible!="" and !@disponible.nil?
        if @disponible=="1"
          if @consulta!=""          
            @consulta+=" and user_id is null "          
          else
            @consulta="user_id is null "          
          end        
        end
      end     
      
      @consulta+=filtra_consulta_str('activo_fijo',@activo_eq).to_s
      logger.debug "*********222222  "+@consulta.to_s
      @consulta+=filtra_consulta_str('serie',@serie_eq).to_s
      logger.debug "*******33333333  "+@consulta.to_s
      
      @equipo=Equipo.paginate(page:params[:page]).where("#{@consulta}")
    else           
      @consulta+=filtra_consulta_int('tipocomp_id',@tipocomp_invt).to_s
      logger.debug "*1111111111111  "+@consulta.to_s
      @consulta+=filtra_consulta_str('no_activo_fijo',@activo).to_s
      logger.debug "*********222222  "+@consulta.to_s
      @consulta+=filtra_consulta_str('no_serie',@serie).to_s
        
      logger.debug "*******33333333  "+@consulta.to_s
      if @marca!="" && !@marca.nil?
        @consutla_m=""
        @comp_marcas=Componente.where("marca =?",@marca)
        @comp_marcas.each.with_index do |co,index|
          if index.to_i == @comp_marcas.length()-1
            @consutla_m+=co.id.to_s
          else
            @consutla_m+=co.id.to_s+","
          end          
        end
        
        if @consulta!=""
          @consulta+=" and componente_id in ("+@consutla_m.to_s+")"
        else
          @consulta=" componente_id in ("+@consutla_m.to_s+")"
        end
      end

      if @disponible!="" and !@disponible.nil?
        if @disponible=="1"
          if @consulta!=""          
            @consulta+=" and disponible=true"          
          else
            @consulta="disponible=true"          
          end        
        end
      end
      @componente_band=true
      logger.debug "********************************************"+@consulta.to_s
      if @consulta==""                
        @componentes=CompSerial.paginate(page:params[:page]).all     
      else       
        logger.debug "***********************   "+@consulta.to_s
        @componentes=CompSerial.paginate(page:params[:page]).where("#{@consulta.to_s}")           
      end
     end 
  end

  def filtra_consulta_str(atributo,parametro)
      consulta=""
    if parametro!="" && !parametro.nil?       
      if @consulta!=""          
        consulta+=" and #{atributo}='"+parametro.to_s+"'"
      else            
        consulta="#{atributo}='"+parametro.to_s+"'"
      end 
    else
      consulta=""
    end
  end
  def filtra_consulta_int(atributo,parametro)
    consulta=""
    if parametro!="" && !parametro.nil?       
      if @consulta!=""          
        consulta+=" and #{atributo}="+parametro.to_s
      else            
        consulta="#{atributo}="+parametro.to_s
      end 
    end
  end

  def show
  end

  def carga_inventario

  end
end
