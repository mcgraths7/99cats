class SessionsController < ApplicationController
  before_action :already_logged_in, only: [:new]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(user_params[:username], user_params[:password])
    if user.nil?
      flash.now[:errors] = user.errors.full_messages
      render :new
    else
      login!(user)
      flash[:notice] = 'Logged in successsfully'
      redirect_to cats_url
    end
  end

  def destroy
    logout!
    flash[:notice] = 'Logged out successfully'
    redirect_to login_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end