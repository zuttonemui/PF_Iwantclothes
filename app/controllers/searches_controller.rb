class SearchesController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == 'user'
      @records = User.search_for(@content, @method)
    elsif @model == 'want_clothes'
      @records = WantClothes.search_for(@content, @method)
    elsif @model == 'recommend'
      @records = Recommend.search_for(@content, @method)
    elsif @model == 'tag'
      @records = Tag.search_want_clothes_for(@content, @method)
    end
  end
end
