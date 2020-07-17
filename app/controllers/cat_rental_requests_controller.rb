class CatRentalRequestsController < ApplicationController
  # def index
  #   @cat_rental_requests = CatRentalRequest.order(:start_date)
  #   render :index
  # end
  
  def new
    @cats = Cat.all
    @cat_rental = CatRentalRequest.new
    render :new
  end

  def create
    @cat_rental = CatRentalRequest.new(rental_params)
    if @cat_rental.save
      flash[:notice] = 'Rental successfully requested'
      render @cat_rental
    else
      flash[:notice] = "Could not book #{requested_cat.name}. Please try a different time frame"
      render :new
    end
  end

  # def show
  #   @cat_rental = current_rental
  #   @cat = requested_cat
  #   render :show
  # end


  private
  def rental_params
    params.require(:rental).permit(:cat_id, :start_date, :end_date)
  end

  def current_rental
    CatRentalRequest.find_by(id: params[:id])
  end

  def requested_cat
    CatRentalRequest.find_by(id: rental_params[:cat_id])
  end

end