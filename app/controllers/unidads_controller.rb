class UnidadsController < ApplicationController
  def index
    @unidad=Unidad.paginate(page:params[:page]).all.order(id: :asc)
  end
  def edit
    @unidad=Unidad.find(params[:id])
  end
  def update
    @unidad=Unidad.find(params[:id])
    if @unidad.update(params_unid)
      redirect_to unidads_path
    else
      render :edit
    end
  end

  def destroy
    @unidad=Unidad.find(params[:id])
    @users=User.where(unidad:@unidad.id)
    @users.update_all(unidad:0)
    @unidad.destroy
    redirect_to unidads_path
  end
  def new
    @unidad=Unidad.new
  end

  def create
    @unidad=Unidad.new(params_unid)
    
    if @unidad.save
      if params[:unidad][:user_id]==""
        redirect_to  new_user_path(solicitud:true)
      else
        redirect_to edit_user_path(params[:unidad][:user_id])      
      end
    else
      render :new
    end

  end


  private
  def params_unid
    params.require(:unidad).permit(:nombre)
  end
end
