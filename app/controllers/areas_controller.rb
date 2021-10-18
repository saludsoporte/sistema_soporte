class AreasController < ApplicationController
  before_action :authenticate_user!
  def index
    @areas=Area.paginate(page:params[:page]).all.order(id: :asc)
  end
  def edit
    @area=Area.find(params[:id])
  end
  def update
    @area=Area.find(params[:id])
    if @area.update(params_unid)
      redirect_to areas_path
    else
      render :edit
    end
  end

  def destroy
    @area=Area.find(params[:id])
    @users=User.where(area:@area.id)
    @users.update_all(area:0)
    @area.destroy
    redirect_to areas_path
  end

  def new
    @area=Area.new
  end
  def create
    @area=Area.new(params_unid)
    if @area.save
      if params[:area][:user_id]==""
        redirect_to  new_user_path(solicitud:true)
      else
        redirect_to edit_user_path(params[:area][:user_id])      
      end
    else
      render :new
    end
  end
  private
  def params_unid
    params.require(:area).permit(:nombre)
  end
end
