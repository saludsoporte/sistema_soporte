class DepartamentosController < ApplicationController
  def index
    @departamento=Departamento.paginate(page:params[:page]).all.order(id: :asc)
  end
  def edit
    @departamento=Departamento.find(params[:id])
  end
  def update
    @departamento=Departamento.find(params[:id])
    if @departamento.update(params_unid)
      redirect_to departamentos_path
    else
      render :edit
    end
  end

  def destroy
    @departamento=Departamento.find(params[:id])
    @users=User.where(departamento:@departamento.id)
    @users.update_all(departamento:0)
    @departamento.destroy
    redirect_to departamentos_path
  end

  def new
    @departamento=Departamento.new
  end
  def create
    @departamento=Departamento.new(params_unid)
    if @departamento.save
      if params[:departamento][:user_id]==""
        redirect_to  new_user_path(solicitud:true)
      else
        redirect_to edit_user_path(params[:departamento][:user_id])      
      end
    else
      render :new
    end
  end
  private
  def params_unid
    params.require(:departamento).permit(:nombre)
  end
end
