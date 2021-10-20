class CaracteristicasController < ApplicationController
  def index
    @caracteristicas=Caracteristica.paginate(page:params[:page]).all.order(id: :asc)
  end

  def show
  end

  def new
    @caracteristica=Caracteristica.new
  end

  def create

    @carac=Caracteristica.where("nombre ilike ('%#{params_carac[:nombre]}%')")
    if @carac.count == 0
      @caracteristica=Caracteristica.new(params_carac)
      if @caracteristica.save
        redirect_to caracteristicas_path
      else
        render :new
      end
    else
      redirect_to new_caracteristica_path(error:true,nombre:params_carac[:nombre])
    end
  end

  def edit
    @caracteristica=Caracteristica.find(params[:id])
  end

  def update
    @caracteristica=Caracteristica.find(params[:id])
    if @caracteristica.update(params_carac)
      redirect_to caracteristicas_path
    else
      render :edit 
    end 
  end

  def destroy 
    @relacion=RelacionCaracteristica.where(caracteristica_id:params[:id])
    @caracteristica=Caracteristica.find(params[:id])
    @relacion.destroy_all
    @caracteristica.destroy
    redirect_to caracteristicas_path
  end 
  private
  def params_carac
    params.require(:caracteristica).permit(:nombre)
  end
end
