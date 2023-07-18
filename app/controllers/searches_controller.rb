class SearchesController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    if @model == 'user'
      @records = User.search_for(@content)
    elsif @model == 'want_item'
      @records = WantItem.search_for(@content)
    elsif @model == 'recommend'
      @records = Recommend.search_for(@content)
    elsif @model == 'tag'
      @records = Tag.search_want_items_for(@content)
    end
  end
end
