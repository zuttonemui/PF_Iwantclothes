class HomesController < ApplicationController
  def top
    render :layout => nil
  end

  def about
    @want_clothes = WantClothes.all.order(created_at: :desc).first(4)
    @recommends = Recommend.all.order(created_at: :desc).first(4)
  end
end
