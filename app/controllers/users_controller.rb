class UsersController < ApplicationController
    before_action :authenticate_user!
    protect_from_forgery with: :exception
    def index    
        
        unless user_signed_in?      
            redirect_to new_user_session_path
        else       
            @q=params[:q]
            if !@q.nil?
                @q="'%"+@q+"%'"
                logger.debug @q
                @users=User.paginate(page:params[:page]).where("nombre_completo ilike (#{@q})").order(id: :asc)
            else
                @users=User.paginate(page:params[:page]).order(id: :asc)
            end
            
        end 
        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @users }
        end
    end
    def  new
        if params[:error]
            logger.debug "//////////////////////////////////////"
            @error=true
        end
        @solicitud_page=params[:solicitud]
        @user=User.new
        @unidad=Unidad.all.order(id: :asc)
        @area=Area.all.order(id: :asc)
        @direccion=Direccion.all.order(id: :asc)
        @departamento=Departamento.all.order(id: :asc)
        @subdireccion=Subdireccion.all.order(id: :asc)
    end
  
    def usuario_add
        logger.debug " Entroooooooooooooooooooooo "
        
        if params[:user][:nombre]!="" && params[:user][:apellido_paterno]!="" && params[:user][:apellido_materno]!=""

            @user=User.new(user_params)

            if @user.save
                if params[:bandera_sol]==true
                    redirect_to new_solicitud_path
                else
                    redirect_to users_path
                end
                
            else    
                render :new
            end
        else            
            redirect_to new_user_path(error:true)
        end
    end
    def show
        @user=User.find(params[:id])
    end

    def update
        @user=User.find(params[:id])
        @perfil=Perfil.find_by(id_usuario:@user.id)

        if @perfil.nil?     
            @email = params[:user][:email]

            if @email== ""
                @email="correo@correo.com"
            end
            @user.update(username:'general',apellido_paterno:params[:user][:apellido_paterno],
            apellido_materno:params[:user][:apellido_materno],
            email:@email,
            area:params[:user][:area],
            subdireccion:params[:user][:subdireccion],
            direccion:params[:user][:direccion],
            departamento:params[:user][:departamento],
            unidad:params[:user][:unidad])

            redirect_to @user
        elsif @user.update(nombre:params[:user][:nombre],
            apellido_paterno:params[:user][:apellido_paterno],
            apellido_materno:params[:user][:apellido_materno],
            email:params[:user][:email],
            area:params[:user][:area],
            subdireccion:params[:user][:subdireccion],
            direccion:params[:user][:direccion],
            departamento:params[:user][:departamento],
            unidad:params[:user][:unidad]
        )
            redirect_to @user
        else
            logger.debug "**********************"
            redirect_to edit_user_path(@user.id)
        end
    end

    def edit
        @user=User.find(params[:id])
        @unidad=Unidad.all.order(id: :asc)
        @area=Area.all.order(id: :asc)
        @subdireccion=Subdireccion.all.order(id: :asc)
        @direccion=Direccion.all.order(id: :asc)
        @departamento=Departamento.all.order(id: :asc)
    end

    private
    def user_params
        params[:user][:password]="123456"
        @numero=User.last.id.to_i+1
        params[:user][:username]="general"+@numero.to_s       
        params[:user][:email]="correo@correo.com"    
        params.require(:user).permit(:nombre,:apellido_paterno,:apellido_materno,:area,:email,:password,:username,:subdireccion,:direccion,:departamento,:unidad)
    end
end