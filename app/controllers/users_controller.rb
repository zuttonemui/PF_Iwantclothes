class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :favorites]

  def index
    if current_user.is_admin == true
      @users = User.where.not(is_admin: true).page(params[:page]).per(10)
    else
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:id])
    if @user == current_user
      @want_items = WantItem.where(user_id: current_user.followings.ids, is_answer: true).page(params[:page]).per(10)
      @recommends = Recommend.where(user_id: current_user.followings.ids).page(params[:page]).per(10)
      params[:user_id]
      params[:id]
    else
      @want_items = @user.want_items.page(params[:page]).per(10)
      @recommends = @user.recommends.page(params[:page]).per(10)
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      flash[:alert] = "必須項目が入力されていません"
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
    if @user.is_active == true
      @user.update(is_active: false)
    else
      @user.update(is_active: true)
    end
    if current_user.is_admin == false
      reset_session
      redirect_to root_path
    else
      redirect_to users_path
    end
  end

  def dm
    @user = User.find(params[:id])
    # 自分と相手のIDをもつEntryがない場合は作る、あれば取得する
    my_room_ids = current_user.entries.pluck(:room_id)
    room_ids = @user.entries.pluck(:room_id)
    room_id = my_room_ids & room_ids

    if room_id.present?
      @room = Room.find(room_id.first)
    else
      @room = Room.new
      @room.save!
      current_user.entries.create!(room_id: @room.id)
      @user.entries.create!(room_id: @room.id)
    end

    @letters = @room.letters
    @letter = Letter.new(room_id: @room.id)
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :instagram, :twitter, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path
    end
  end
end
