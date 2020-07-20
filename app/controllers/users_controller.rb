class UsersController < ApplicationController
  before_action :already_logged_in, only: [:new]
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    @user.session_token = User.generate_session_token
    if @user.save
      login!(@user)
      flash[:notice] = 'Logged in successfully!'
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end