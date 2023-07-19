class LettersController < ApplicationController
  before_action :reject_non_related, only: [:show]

  def show

  end

  def create
    @letter = current_user.letters.new(letter_params)
    render :validater unless @letter.save
  end

  private
  def letter_params
    params.require(:letter).permit(:message, :room_id)
  end

  def reject_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to user_path(current_user)
    end
  end
end