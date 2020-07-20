class CatsController < ApplicationController
  before_action :require_current_user!, only: [:new, :edit]
  before_action :current_user_must_own_cat, only: [:edit, :update]

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
    @cat.user_id = current_user.id
    if @cat.save
      flash[:notice] = 'Cat successfully created!'
      redirect_to cat_url(@cat)
    else
      flash.now[:error] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = current_cat
    render :edit
  end

  def update
    if current_cat.update_attributes(cat_params)
      flash[:notice] = 'Cat successfully updated'
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :description, :name, :sex)
  end

  def current_cat
    @cat = Cat.find(params[:id])
  end

  def current_user_must_own_cat
    unless current_user.cats.where(id: current_cat[:id]).exists?
      flash[:errors] = "Cannot edit someone else's cat"
      redirect_to cats_url
    end
  end
end
