class HomesController < ApplicationController
  def top
    @want_items = WantItem.all.order(created_at: :desc).first(4)
    @recommends = Recommend.all.order(created_at: :desc).first(4)
  end
end
