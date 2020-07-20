class SessionsController < ApplicationController
  before_action :already_logged_in, only: [:new]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(user_params[:username], user_params[:password])
    if user.nil?
      render json: 'Incorrect username/password'
    else
      login!(user)
      redirect_to cats_url
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end