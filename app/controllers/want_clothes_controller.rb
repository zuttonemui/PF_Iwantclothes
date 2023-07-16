class WantClothesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    if params[:id].present?
      @want_clothes = WantClothes.where.not(id: params[:id]).order(created_at: :desc)
      @want_clothing = WantClothes.find(params[:id])
    else
      @want_clothes = WantClothes.all.order(created_at: :desc)
      @want_clothing = WantClothes.new
    end
    @answer = WantAnswer.new
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @want_clothing = WantClothes.new(want_clothes_params)
    @want_clothing.user_id = current_user.id
    tag_list = params[:want_clothes][:tag_name].split(',')
    if @want_clothing.save
      @want_clothing.save_tags(tag_list)
      redirect_to want_clothes_path
    else
      @want_clothes = WantClothes.all
      render 'index'
    end
  end

  def edit
    @want_clothes = WantClothes.all.order(created_at: :desc)
    unless @want_clothing.user == current_user
      redirect_to want_clothes_path
    end
  end

  def update
    if @want_clothing.update(want_clothes_params)
      redirect_to want_clothes_path
    else
      render 'edit'
    end
  end

  def destroy
    unless @want_clothing.user == current_user || user.is_admin == true
      redirect_to want_clothes_path
    end
    @want_clothing.destroy
    redirect_to want_clothes_path
  end

  private
  def ensure_correct_user
    @want_clothing = WantClothes.find(params[:id])
  end

  def want_clothes_params
    params.require(:want_clothes).permit(:genre_id, :content, :budget, :is_answer, :want_image)
  end
end
