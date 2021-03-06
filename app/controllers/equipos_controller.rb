class EquiposController < ApplicationController
  def index
    @equipos=Equipo.paginate(page:params[:page]).all.order(id: :asc)
  end

  def show
    @equipo=Equipo.find(params[:id])
    @componentes=RelacionComponente.paginate(page:params[:page]).where("equipo_id = ?",@equipo.id)    
  end

  def edit
    @equipo=Equipo.find(params[:id])
    @usuarios=User.all
    @area=Area.all
    @subdireccion=Subdireccion.all
    @direccion=Direccion.all
    @departamento=Departamento.all
    @unidad=Unidad.all

    if !@equipo.user_id.nil?
      @user=User.find(@equipo.user_id)      
    else
      @equipo.user_id=0
    end
    @edit=true
  end
 
  def update
    @tipocomp=Tipocomp.find_by("nombre = 'Equipo de Computo'")
    @equipo=Equipo.find(params[:id])
    if @equipo.user_id.nil? && !params[:equipo][:user_id].nil?
        @band_disminuir=true
    end
    if @equipo.update(equipo_params)
      
      @disponible=Inventario.find_by("tipocomp_id=?",@tipocomp.id).disponibles
      @inventario=Inventario.find_by("tipocomp_id = ?",@tipocomp.id)
      
      if params[:equipo][:user_id].nil?
        @inventario.update(disponibles:@disponible+1)      
        @user="sin usuario asignado"
        @log=LogEquipo.new(
          accion:"update->del_usuario",
          descripcion:"Se actualiza el equipo y el inventario aumenta una a los disponibles, elimina el usuario asignado",
          user_asignado:@user,
          user_asignado_id:@equipo.user_id,
          equipo_id:@equipo.id
        )
      elsif @band_disminuir
        @inventario.update(disponibles:@disponible-1)      
        @user=User.find(@equipo.user_id)
        @log=LogEquipo.new(
          accion:"update->asigna_usuario",
          descripcion:"Se actualiza el equipo y el inventario disminuye una a los disponibles, asigna un usuario al equipo",
          user_asignado:@user.nombre_personal,
          user_asignado_id:@equipo.user_id,
          equipo_id:@equipo.id
        )
      else
        @user=User.find(@equipo.user_id)
        @log=LogEquipo.new(
          accion:"update",
          descripcion:"Se actualiza el equipo",
          user_asignado:@user.nombre_personal,
          user_asignado_id:@equipo.user_id,
          equipo_id:@equipo.id
        )
      end
      @log.save
      
      
      redirect_to equipo_path(params[:id])
    else
      render :edit
    end 
  end

  def new
    @usuarios=User.all.order(id: :asc)
    @area=Area.all.order(id: :asc)
    @subdireccion=Subdireccion.all.order(id: :asc)
    @direccion=Direccion.all.order(id: :asc)
    @departamento=Departamento.all.order(id: :asc)
    @unidad=Unidad.all.order(id: :asc)    
    @equipo=Equipo.new
    @edit=false
  end
  def create
    #@equipo_q=Equipo.find_by("activo_fijo = ?",params[:equipo][:activo_fijo])
    logger.debug "#33###################3 "+@equipo_q.nil?.to_s
    #if @equipo_q.nil? == true 
    @equipo=Equipo.new(equipo_params)    
    if @equipo.save
      if @equipo.user_id.nil?
        @user="Sin usuario asignado"
      else
        @user=User.find(@equipo.user_id).nombre_personal
      end
      @log=LogEquipo.new(
        accion:"create",
        descripcion:"se ha creado un equipo nuevo ",
        user_asignado:@user,
        user_asignado_id:@equipo.user_id,
        equipo_id:@equipo.id
      )
      @log.save

      @inventario_f=Inventario.find_by("tipocomp_id=?",@equipo.tipocomp_id)
      if @inventario_f.nil?        
        if !@equipo.user_id.nil?
          logger.debug "***************** con user"   
          @disponibles=0                           
        else
          logger.debug "***************** sin user"
          @disponibles=1          
        end     
        @inventario=Inventario.new(tipocomp_id:@equipo.tipocomp_id,cantidad:1,disponibles:@disponibles)       
        @inventario.save
        @log=LogEquipo.new(
          accion:"create-> Inventario",
          descripcion:"se ha creado un registro nuevo en el inventario",
          user_asignado:@equipo.user.nombre_completo,
          user_asignado_id:@equipo.user_id,
          equipo_id:@equipo.id
        )
        @log.save

      else
        if @equipo.user_id.nil?
          @cantidad=@inventario_f.cantidad
          @disponibles=@inventario_f.disponibles
          @log_disponibles="y disponibles de #{@disponibles} a #{@disponibles+1}"
          @inventario_f.update(cantidad:@cantidad+1,disponibles:@disponibles+1)          
        else
          @cantidad=@inventario_f.cantidad
          @log_disponibles=""
          @inventario_f.update(cantidad:@cantidad+1)
        end      
        if @equipo.user_id.nil?
          @user="Sin usuario asignado"
        else
          @user=User.find(@equipo.user_id).nombre_personal
        end 
        @log=LogEquipo.new(
          accion:"update-> Inventario",
          descripcion:"se ha actualizado un registro en el inventario, se aumento la cantidad #{@cantidad} a #{@cantidad +1} #{@log_disponibles}",
          user_asignado:@user,
          user_asignado_id:@equipo.user_id,
          equipo_id:@equipo.id
        )
        @log.save
      end
    
      redirect_to new_relacion_componente_path(equipo_id:@equipo.id)      
    else
      @usuarios=User.all.order(id: :asc)
      @area=Area.all.order(id: :asc)
      @subdireccion=Subdireccion.all.order(id: :asc)
      @direccion=Direccion.all.order(id: :asc)
      @departamento=Departamento.all.order(id: :asc)
      @unidad=Unidad.all.order(id: :asc)    
      render :new
    end 
    #else
    #  logger.debug "888888888888888888888888888888888888888888888888888888888"
    #  redirect_to new_equipo_path(error:1)      
    #  
    #end    
  end

  def quitar_asignacion
    @tipocomp=Tipocomp.find_by("nombre = 'Equipo de Computo'")
    @inventario=Inventario.find_by("tipocomp_id = ? ",@tipocomp.id)
    @disponible=@inventario.disponibles.to_i+1    
    @equipo=Equipo.find(params[:id])
    if @inventario.update(disponibles:@disponible)
      @log=LogEquipo.new(
        accion:"update-> Inventario",
        descripcion:"se ha actualizado un registro en el inventario, se actualizaron los disponibles a #{@disponible}",
        user_asignado:@equipo.user.nombre_personal,
        user_asignado_id:@equipo.user_id,
        equipo_id:@equipo.id
      )
      @log.save
    end
    @user=@equipo.user
    if @equipo.update(user_id:nil)
      @log=LogEquipo.new(
        accion:"update-> Equipos",
        descripcion:"se ha actualizado equipo #{@equipo.id} , se elimino el usuario #{@user.id}",
        user_asignado:@user.nombre_personal,
        user_asignado_id:@user_id,
        equipo_id:@equipo.id
      )
      @log.save
    end
    redirect_to equipo_path(params[:id])
  end

  def cargar_equipo_completo    
    if params[:no_serie]!="" && params[:no_activo_fijo]!=""    
      @equipo_q=Equipo.find_by("activo_fijo = ?",params[:no_activo_fijo])
      logger.debug "#33###################3 "+@equipo_q.nil?.to_s
      if @equipo_q.nil? == true 
        if params[:tipo]=='escritorio' or params[:tipo]=='laptop'        
          @tipocomp=Tipocomp.find_by("nombre='Equipo de Computo'").id
          else        
          @tipocomp=Tipocomp.find_by("nombre='Servidor'").id
        end
        if params[:user_id].nil?
          @user_id=nil
          else
          @user_id=params[:user_id]
        end
        @equipo=Equipo.new(no_serie:params[:no_serie],
          activo_fijo:params[:no_activo_fijo],
          tipo:params[:tipo],
          piso:params[:piso],        
          user_id:@user_id,
          tipocomp_id:@tipocomp,
          area:params[:area],
          subdireccion:params[:subdireccion],
          direccion:params[:direccion],
          departamento:params[:departamento],
          unidad:params[:unidad]
        )
        @inventario_f=Inventario.find_by("tipocomp_id=?",@tipocomp) 
        @cantidad=@inventario_f.cantidad+1
        @disponible=@inventario_f.disponibles
        if @user_id.nil?
          @disponible+=1
        end            
        if @equipo.save
          @inventario_f.update(cantidad:@cantidad,disponibles:@disponible)
          logger.debug "//////////////////////////////////"
          crearRam(@equipo.id)
          crearHDD(@equipo.id)
          crearProc(@equipo.id)
          logger.debug "*****************"
          redirect_to equipos_path
        end 
      else
        redirect_to new_equipo_path(completo:true,error:1)
      end
    else
      redirect_to new_equipo_path(completo:true,error:2)
    end    
  end

  def destroy
    @tipo=Tipocomp.find_by("nombre='Equipo de Computo'")   
    @equipo=Equipo.find(params[:id])
    @relaciones=RelacionComponente.where("equipo_id=?",params[:id])
    #update el inventario , para cada componente devuelto 
    @relaciones.each do |r|
      @comp_serial=CompSerial.find(r.comp_serial_id)
      @comp_serial.update(disponible:true)
      @log=LogEquipo.new(
        accion:"update-> Existencias",
        descripcion:"Se prepara para eliminar el componente #{@comp_serial.tipocomp.nombre} con id: #{@comp_serial.id} ",
        user_asignado:@equipo.user_nombre,
        user_asignado_id:@equipo.user_id,
        equipo_id:@equipo.id
      )
      @log.save
      @inventario_f=Inventario.find_by(tipocomp_id:@comp_serial.tipocomp_id)
      @disponible=@inventario_f.disponibles
      @inventario_f.update(disponibles:@disponible+1)
    end

    if @relaciones.destroy_all
      if@equipo.destroy
        @inventario_f=Inventario.find_by(tipocomp_id:@tipo.id)
        @disponibles=@inventario_f.disponibles
        @cantidad=@inventario_f.cantidad
        @inventario_f.update(cantidad:@cantidad-1,disponibles:@disponibles-1)  
        
        @log=LogEquipo.new(
          accion:"update-> Inventario",
          descripcion:"Se ha actualizado un registro en el inventario, cantidad: #{@inventario.cantidad} , disponible:#{@inventario_f.disponibles}",
          user_asignado:@equipo.user_nombre,
          user_asignado_id:@equipo.user_id,
          equipo_id:@equipo.id
        )
        @log.save
      end      
    end
    redirect_to equipos_path
  end
  def equipo_params
    params[:equipo][:tipo]=params[:tipo]    
    if params[:tipo]=='escritorio' or params[:tipo]=='laptop'
      logger.debug "Sdasdasdasdd  *///////////////////"
      params[:equipo][:tipocomp_id]=Tipocomp.find_by("nombre='Equipo de Computo'").id
    else
      logger.debug "***************  *///////////////////"
      params[:equipo][:tipocomp_id]=Tipocomp.find_by("nombre='Servidor'").id
    end

    if params[:equipo][:user_id].nil? 
      logger.debug "/*/*/*/*/*///////////////////////////////*"
      params[:equipo][:user_id]=nil
    end
    params.require(:equipo).permit(:user_id,:tipo,:piso,:tipocomp_id,:activo_fijo,:no_serie,:area,:subdireccion,:direccion,:departamento,:unidad)
  end

  private
    def crearRam(equipo_id)
      if params[:tipo_mem]!="" && params[:ram_cp]!="" && params[:no_ram]!=""
        @tipo=Tipocomp.find_by("nombre = 'Ram'")
        @ram=Componente.find_by("marca='All in one' and modelo='All in one' and tipocomp_id=?",@tipo.id) 
        @inventario_f=Inventario.find_by("tipocomp_id=?",@tipo.id)     
        @numero=params[:no_ram]
        i=0
        @carac=Caracteristica.find_by("nombre = 'Capacidad de Memoria'")
        @tipocamp=Caracteristica.find_by("nombre = 'Tipo de Memoria'")
        #@conjuntos=RelacionCaracteristica.where("componente_id=? ",@ram.id).order(conjunto: :asc).distinct
        @capacidad=params[:ram_cp]+params[:mem_size]
        @tipo_mem=params[:tipo_mem]        
                
        @caracteristicas=RelacionCaracteristica.find_by("  componente_id=? and caracteristica_id=? and valor_caracteristica=?",@ram.id,@tipocamp.id,@tipo_mem)
        @caracteristicas2=RelacionCaracteristica.find_by(" componente_id=? and caracteristica_id=? and valor_caracteristica=?",@ram.id,@carac.id,@capacidad)
        if @caracteristicas.nil?         
          @caracteristicas=RelacionCaracteristica.new(componente_id:@ram.id,caracteristica_id:@carac.id,valor_caracteristica:@capacidad)
          @caracteristicas.save
          logger.debug "******************* carac "+@caracteristicas.id.to_s
        end
        
        if @caracteristicas2.nil?   
          @caracteristicas2=RelacionCaracteristica.new(componente_id:@ram.id,caracteristica_id:@tipocamp.id,valor_caracteristica:@tipo_mem)
          @caracteristicas2.save                                       
        end
        @conjunto=@caracteristicas.id.to_s+","+@caracteristicas2.id.to_s
        while i < @numero.to_i         
          @comp_serie=@ram.comp_serials.create(
          componente_id:@ram.id,
          no_serie:params[:no_serie],
          no_activo_fijo:params[:no_activo_fijo],
          tipocomp_id:@ram.tipocomp_id,
          disponible:false,
          conjunto:@conjunto)
          @comp_serie.save

          @relacion_componente=RelacionComponente.new(
          componente_id:@ram.id,equipo_id:equipo_id,comp_serial_id:@comp_serie.id
          )
          @relacion_componente.save
          @cantidad=@inventario_f.cantidad
          @inventario_f.update(cantidad:@cantidad+1)
          i=i+1
        end
      end      
    end
    def crearHDD(equipo_id)
      if params[:hdd_cap]!="" 
        @tipo=Tipocomp.find_by("nombre = 'Disco Duro'")
        @hdd=Componente.find_by("marca='All in one' and modelo='All in one' and tipocomp_id=?",@tipo.id) 
        @inventario_f=Inventario.find_by("tipocomp_id=?",@hdd.tipocomp_id)   
        #@conjuntos=RelacionCaracteristica.where("componente_id=? ",@hdd.id).order(conjunto: :asc).distinct 
        @carac=Caracteristica.find_by("nombre = 'Capacidad de Memoria'")
        @carac2=Caracteristica.find_by("nombre = 'Tipo de Disco Duro'")
        @capacidad=params[:hdd_cap]+params[:hdd_mem_size]
        @tipo=params[:tipoHDD]
        @nuevo=true

        @caracteristicas=RelacionCaracteristica.find_by("  componente_id=? and caracteristica_id=? and valor_caracteristica=?",@hdd.id,@carac.id,@capacidad)
        @caracteristicas2=RelacionCaracteristica.find_by(" componente_id=? and caracteristica_id=? and valor_caracteristica=?",@hdd.id,@carac2.id,@tipo)
        logger.debug "*********** carac1"+@caracteristicas.nil?.to_s
        logger.debug "*********** carac2"+@caracteristicas2.nil?.to_s
        if @caracteristicas.nil? 
          @caracteristicas=RelacionCaracteristica.new(componente_id:@hdd.id,caracteristica_id:@carac.id,valor_caracteristica:@capacidad)
          @caracteristicas.save
          logger.debug "******************* carac "+@caracteristicas.id.to_s
        end
        if @caracteristicas2.nil?          
          @caracteristicas2=RelacionCaracteristica.new(componente_id:@hdd.id,caracteristica_id:@carac2.id,valor_caracteristica:@tipo)
          @caracteristicas2.save                                       
        end
        @conjunto = @caracteristicas.id.to_s+","+@caracteristicas2.id.to_s
=begin
        if @conjuntos.count > 0
          @conjuntos.each do |cj|
            @relacion=RelacionCaracteristica.where(" componente_id=? and caracteristica_id=? and valor_caracteristica = '#{@capacidad}' and conjunto=?",@hdd.id,@carac.id,cj.conjunto)            
            @relacion2=RelacionCaracteristica.where(" componente_id=? and caracteristica_id=? and valor_caracteristica = '#{params[:tipoHDD]}' and conjunto=?",@hdd.id,@carac2.id,cj.conjunto)                        
            if @relacion.count==0 && @relacion2.count==0
              @nuevo=true
            else              
              @conjunto=cj.conjunto      
              @nuevo=false 
              break
            end
          end
          if @nuevo==true
            @conjunto=setConjunto(@hdd).to_i
          end
        else
          @conjunto=0
        end
=end       
        @comp_serie=@hdd.comp_serials.create(
          componente_id:@hdd.id,
          no_serie:params[:no_serie],
          no_activo_fijo:params[:no_activo_fijo],
          tipocomp_id:@hdd.tipocomp_id,
          disponible:false,
          conjunto:@conjunto
        )
        @relacion_componente=RelacionComponente.new(
          componente_id:@hdd.id,equipo_id:equipo_id,comp_serial_id:@comp_serie.id
        )
        @relacion_componente.save
        @cantidad=@inventario_f.cantidad
        @inventario_f.update(cantidad:@cantidad+1)
      end
    end
    def crearProc(equipo_id)
      if params[:proc_marca]!="" && params[:proc_model]!="" && params[:frecuencia]!="" 
        @tipo=Tipocomp.find_by("nombre = 'Procesador'")
        @procesador=Componente.find_by("marca ilike ('%#{params[:proc_marca]}%') and modelo ilike ('%#{params[:proc_model]}%') ")
        logger.debug " */*/*/*/*/*/*/*"+@procesador.nil?.to_s
        if @procesador.nil?
          @procesador=Componente.new(tipocomp_id:@tipo.id,modelo:params[:proc_model],marca:params[:proc_marca])
          @procesador.save          
          logger.debug "Guardo el procesador"
        end
        @inventario_f=Inventario.find_by("tipocomp_id=?",@procesador.tipocomp_id)           
        
        #@conjuntos=RelacionCaracteristica.where("componente_id=? ",@procesador.id).order(conjunto: :asc).distinct 
        @carac=Caracteristica.find_by("nombre = 'Frecuencia'")
        @frecuencia=params[:frecuencia]+params[:frenc_tipo]
        @nuevo=true
=begin
        if @conjuntos.count > 0
          @conjuntos.each do |cj|
            @relacion=RelacionCaracteristica.where(" componente_id=? and caracteristica_id=? and valor_caracteristica = '#{@frecuencia}' and conjunto=?",@procesador.id,@carac.id,cj.conjunto)            
            if @relacion.count==0             
              @nuevo=true
            else              
              @conjunto=cj.conjunto      
              @nuevo=false 
              break
            end
          end
          if @nuevo==true
            @conjunto=setConjunto(@procesador).to_i
          end
        else
          @conjunto=0
        end
=end 
      @relacion=RelacionCaracteristica.find_by("componente_id=? and caracteristica_id=? and valor_caracteristica=?",@procesador.id,@carac.id,@frecuencia)
      if @relacion.nil? 
        @relacion=RelacionCaracteristica.new(componente_id:@procesador.id,caracteristica_id:@carac.id,valor_caracteristica:@frecuencia)
        @relacion.save                             
      end
      @conjunto = @relacion.id

      @comp_serie=@procesador.comp_serials.create(
        componente_id:@procesador.id,
        no_serie:params[:no_serie],
        no_activo_fijo:params[:no_activo_fijo],
        tipocomp_id:@procesador.tipocomp_id,
        disponible:false,
        conjunto:@conjunto
      )
      @relacion_componente=RelacionComponente.new(
        componente_id:@procesador.id,equipo_id:equipo_id,comp_serial_id:@comp_serie.id
      )
      @relacion_componente.save
      @cantidad=@inventario_f.cantidad
      @inventario_f.update(cantidad:@cantidad+1)
      end
    end  


  def setConjunto(componente)
    logger.debug "entro en nil"
    @consulta=RelacionCaracteristica.where("componente_id=?",componente.id).select(:conjunto).order(conjunto: :desc).limit(1).distinct
    @conjunto=@consulta[0][:conjunto]+1
  end
end
