class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :favorites, :unsubscribe, :withdraw]

  def show
    @user = User.find(params[:id])
    @want_clothes = WantClothes.where(user_id: @user.id, is_answer: true)
    @recommends = @user.recommends.first(2)
    
    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_user_entry.each do |cu|
        @user_entry.each do |u|
          if cu.room_id == u.room_id then
            @is_room = true
            @room_id = cu.room_id
          end
        end
      end
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
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
