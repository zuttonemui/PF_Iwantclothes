class RecommendsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @recommends = Recommend.all.order(created_at: :desc)
    if params[:id].present?
      @recommend = Recommend.find(params[:id])
    else
      @recommend = Recommend.new
    end
  end

  def create
    @recommend = Recommend.new(recommend_params)
    @recommend.user_id = current_user.id
    # tag_list = params[:recommends][:tag_name].split(',')
    if @recommend.save
      # @recommend.save_tags(tag_list)
      redirect_to recommends_path
    else
      @user = current_user
      render 'new'
    end
  end

  def edit
    unless @recommend.user == current_user
      redirect_to recommends_path
    end
  end

  def update
    if @recommend.update(recommend_params)
      redirect_to recommends_path
    else
      render 'edit'
    end
  end

  def destroy
    unless @recommend.user == current_user || user.is_admin == true
      redirect_to recommends_path
    end
    @recommend.destroy
    redirect_to recommends_path
  end

  private
  def ensure_correct_user
    @recommend = Recommend.find(params[:id])
  end

  def recommend_params
    params.require(:recommend).permit(:genre_id, :content, :recommend_image, :url)
  end
end
