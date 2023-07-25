class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @notifications = @user.passive_notifications.page(params[:page]).per(15)
    @notifications.where(is_checked: false).each do |notification|
      notification.update(is_checked: true)
    end
  end
end
