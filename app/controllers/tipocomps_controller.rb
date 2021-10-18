class TipocompsController < ApplicationController
  def index
    @tipos=Tipocomp.paginate(page:params[:page]).all.order(id: :asc)
  end

  def show
  end

  def new
    @tipo=Tipocomp.new
  end

  def create
    @tipo=Tipocomp.new(params_tipo)
    if @tipo.save
      redirect_to tipocomps_path
    else
      render :new
    end
  end
  def edit
    @tipo=Tipocomp.find(params[:id])
  end

  def update
    @tipo=Tipocomp.find(params[:id])
    if @tipo.update(params_tipo)
      redirect_to tipocomps_path
    else
      render :edit
    end
  end
  private 
  def params_tipo
    params.require(:tipocomp).permit(:nombre)
  end 
end
