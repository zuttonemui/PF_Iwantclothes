class SearchesController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    if @model == 'user'
      @records = User.search_for(@content)
    elsif @model == 'want_clothes'
      @records = WantClothes.search_for(@content)
    elsif @model == 'recommend'
      @records = Recommend.search_for(@content)
    elsif @model == 'tag'
      @records = Tag.search_want_clothes_for(@content)
    end
  end
end
