class RecommendsController < ApplicationController
  before_action :authenticate_user!, expect: [:index]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @recommends = Recommend.all
  end

  def new
    @recommend = Recommend.new
  end

  def create
    @recommend = Recommend.new(recommends_params)
    @recommend.id = current_user.id
    # tag_list = params[:recommends][:tag_name].split(',')
    if @recommend.save
      # @recommend.save_tags(tag_list)
      redirect_to recommends_path
    else
      @recommends = RecoMmend.all
      render 'index'
    end
  end

  def edit
    unless @recommend.user == current_user
      redirect_to recommends_path
    end
  end

  def update
    if @recommend.update(recommends_patams)
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

  def recommends_params
    params.require(:recommends).permit(:genre_id, :content, :recommend_image)
  end
end
