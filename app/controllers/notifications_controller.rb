class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @notifications = current_user.passive_notifications.all
    @notifications.where(is_checked: false).each do |notification|
      notification.update(is_checked: true)
    end
  end
end
