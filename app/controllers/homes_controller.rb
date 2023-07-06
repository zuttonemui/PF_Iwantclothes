class HomesController < ApplicationController
  def top
    render :layout => "top_layout"
  end

  def about
    render :layout => "about_layout"
  end
end
