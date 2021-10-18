class PermisosController < ApplicationController
    before_action :authenticate_user!
    def index
        @permisos=Permiso.paginate(page:params[:page],per_page:10)
    end
    def show
        @permiso=Permiso.find(params[:id])
    end
    def new
        @permisos=Permiso.all
        @permiso=Permiso.new
    end
    def create
        @permiso = Permiso.new(permiso_params)
        if @permiso.save
            redirect_to @permiso
        else
            render new
        end
    end
    
    def destroy
        @permiso=Permiso.find(params[:id])
        @relacion=RelacionPerRol.where(permiso_id:params[:id])
        @error=false
        if @relacion.count > 0
            if !@relacion.destroy_all
                @error=true                                
            end                    
        end

        if !@error
            if @permiso.destroy
                redirect_to permisos_path
            else
                render :index
            end
        end

    end
    
    private 
    def permiso_params
        params.require(:permiso).permit(:permiso)

    end
end
