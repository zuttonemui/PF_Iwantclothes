class WantAnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :destroy]

  def create
    want_item = WantItem.find(params[:want_item_id])
    @answer = WantAnswer.new(want_answer_params)
    @answer.user_id = current_user.id
    @answer.want_item_id = want_item.id
    if @answer.save
      flash[:notice] = "コメントを投稿しました"
      @answer.want_item.create_notification_answer!(current_user, @answer.id)
      respond_to :js
    else
      render want_items_path
    end
  end

  def destroy
    @answer = WantAnswer.find_by(id: params[:id], want_item_id: params[:want_item_id])
    @answer.destroy
    flash[:notice] = "コメントを削除しました"
    respond_to :js
  end

  private
  def want_answer_params
    params.require(:want_answer).permit(:content)
  end

  def ensure_correct_user
    unless @want_answer.user == current_user || current_user.is_admin == true
      redirect_to want_items_path
    end
  end
end
