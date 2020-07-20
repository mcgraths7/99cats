class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(user_params)
    if user.nil?
      render json: 'Incorrect username/password'
    else
      session_token = user.reset_session_token!
      session[:session_token] = session_token
      redirect_to cats_url
    end
  end

  def destroy
    @user = current_user
    unless @user.nil?
      @user.reset_session_token!
    end
    session[:session_token] = ""
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end