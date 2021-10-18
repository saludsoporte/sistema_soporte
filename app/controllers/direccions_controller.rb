class DireccionsController < ApplicationController
  def index
    @direccion=Direccion.paginate(page:params[:page]).all.order(id: :asc)
  end
  def edit
    @direccion=Direccion.find(params[:id])
  end
  def update
    @direccion=Direccion.find(params[:id])
    if @direccion.update(params_unid)
      redirect_to direccions_path
    else
      render :edit
    end
  end

  def destroy
    @direccion=Direccion.find(params[:id])
    @users=User.where(direccion:@direccion.id)
    @users.update_all(direccion:0)
    @direccion.destroy
    redirect_to direccions_path
  end
  
  
  def new
    @direccion=Direccion.new
  end

  def create
    @direccion=Direccion.new(params_unid)
    if @direccion.save
      if params[:direccion][:user_id]==""
        redirect_to  new_user_path(solicitud:true)
      else
        redirect_to edit_user_path(params[:direccion][:user_id])      
      end
    else
      render :new
    end
  end
  private
  def params_unid
    params.require(:direccion).permit(:nombre)
  end
end
