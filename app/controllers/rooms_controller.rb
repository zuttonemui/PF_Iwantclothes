class RoomsController < ApplicationController
  def index
    @rooms = Room.all.order(updated_at: :desc)
  end
end
