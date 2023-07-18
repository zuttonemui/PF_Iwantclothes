class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :favorites]

  def show
    @user = User.find(params[:id])
    @want_items = WantItem.where(user_id: @user.id, is_answer: true)
    @recommends = @user.recommends.first(2)
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

  def favorites
    favorites = Favorite.where(user_id: @user.id).pluck(:recommend_id)
    @favorite_recommends = Recommend.find(favorites)
  end

  def unsubscribe
    @user = User.find(params[:user_id])
  end

  def withdraw
    @user = User.find(params[:user_id])
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
