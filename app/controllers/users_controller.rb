class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :unsubscribe, :withdraw]

  def show
    @user = User.find(params[:id])
    # @want_clothes = @user.want_clothes
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def unsubscribe
  end

  def withdraw
    @user.update(is_active: false)
    reset_session
    redirect_to about_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
      @user = User.find(params[:id])
    unless @user ==current_user
      redirect_to about_path
    end
  end
end
