class WantItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    if params[:id].present?
      @want_items = WantItem.where.not(id: params[:id]).order(created_at: :desc)
      @want_item = WantItem.find(params[:id])
    else
      @want_items = WantItem.all.order(created_at: :desc)
      @want_item = WantItem.new
    end
    @answer = WantAnswer.new
    @categories = Category.all
    @category = Category.new
    @tags = Tag.all
  end

  def create
    @want_item = WantItem.new(want_item_params)
    @want_item.user_id = current_user.id
    tag_list = params[:want_item][:tag_name].split(',')
    if @want_item.save
      @want_item.save_tags(tag_list)
      redirect_to want_items_path
    else
      @want_items = WantItem.all
      render 'index'
    end
  end

  def edit
    @want_items = WantItem.all.order(created_at: :desc)
    unless @want_item.user == current_user
      redirect_to want_items_path
    end
  end

  def update
    if @want_item.update(want_item_params)
      redirect_to want_items_path
    else
      render 'edit'
    end
  end

  def destroy
    unless @want_item.user == current_user || user.is_admin == true
      redirect_to want_items_path
    end
    @want_item.destroy
    redirect_to want_items_path
  end

  private
  def ensure_correct_user
    @want_item = WantItem.find(params[:id])
  end

  def want_item_params
    params.require(:want_item).permit(:genre_id, :content, :budget, :is_answer, :want_image)
  end
end
