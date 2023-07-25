class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    recommend = Recommend.find(params[:recommend_id])
    @favorite = current_user.favorites.new(recommend_id: recommend.id)
    @favorite.save!
    @favorite.recommend.create_notification_fav!(current_user)
    render 'replace_btn'
  end

  def destroy
    recommend = Recommend.find(params[:recommend_id])
    @favorite = current_user.favorites.find_by(recommend_id: recommend.id)
    @favorite.destroy!
    render 'replace_btn'
  end
end
