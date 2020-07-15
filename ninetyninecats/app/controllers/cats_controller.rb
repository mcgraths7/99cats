class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = current_cat
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      render @cat
    else
      render :new
    end
  end

  def edit
    @cat = current_cat
    render :edit
  end

  def update
    @cat = current_cat
    if @cat.update(cat_params)
      render @cat
    else
      render :edit
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :birth_date, :color, :sex, :description)
  end
  def current_cat
    Cat.find_by(id: params[:id])
  end
end