class CatRentalRequestsController < ApplicationController
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

  def approve
    if current_rental.approve!
      redirect_to proc { cat_url(current_rental.cat_id) }
    else
      render json: 'Could not approve rental request'
    end
  end

  def deny
    if current_rental.deny!
      redirect_to proc { cat_url(current_rental.cat_id) }
    else
      render json: 'Could not deny rental request'
    end
  end

  private
  def rental_params
    params.require(:rental).permit(:cat_id, :start_date, :end_date)
  end

  def current_rental
    CatRentalRequest.find_by(id: params[:id])
  end
end