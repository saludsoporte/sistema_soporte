class SubdireccionsController < ApplicationController
  def index
    @subdireccion=Subdireccion.paginate(page:params[:page]).all.order(id: :asc)
  end
  def edit
    @subdireccion=Subdireccion.find(params[:id])
  end
  def update
    @subdireccion=Subdireccion.find(params[:id])
    if @subdireccion.update(params_unid)
      redirect_to subdireccions_path
    else
      render :edit
    end
  end

  def destroy
    @subdireccion=Subdireccion.find(params[:id])
    @users=User.where(subdireccion:@subdireccion.id)
    @users.update_all(subdireccion:0)
    @subdireccion.destroy
    redirect_to subdireccions_path
  end
  def new
    @subdireccion=Subdireccion.new
  end
  def create
    @subdireccion=Subdireccion.new(params_unid)
    if @subdireccion.save
      if params[:subdireccion][:user_id]==""
        redirect_to  new_user_path(solicitud:true)
      else
        redirect_to edit_user_path(params[:subdireccion][:user_id])      
      end
    else
      render :new
    end
  end
  private
  def params_unid
    params.require(:subdireccion).permit(:nombre)
  end
end
