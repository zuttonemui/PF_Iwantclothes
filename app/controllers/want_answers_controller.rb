class WantAnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    want_clothes = WantClothes.find(params[:want_clothes_id])
    @answer = WantAnswer.new(want_answer_params)
    @answer.user_id = current_user.id
    @answer.want_clothes_id = want_clothes.id
    @answer.save
  end

  def destroy
    @answer = WantAnswer,find_by(id: params[:id], want_id: params[:want_id])
    @answer.destroy
  end

  private
  def want_answer_params
    params.require(:want_answer).permit(:content, :url)
  end
end
