class RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @room = Room.create
    @entry1 = Entry.create(:rom_id => @room.id, :user_id => current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit)
  end
end
