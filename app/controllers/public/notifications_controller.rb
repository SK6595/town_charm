class Public::NotificationsController < ApplicationController

  before_action :authenticate_user!

  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    # 通知の種類によるリダイレクトパスの生成
    case notification.notifiable_type
    when "Favorite"
      redirect_to post_path(notification.notifiable.post)
    when "Comment"
      redirect_to post_path(notification.notifiable.post)
    when "Post"
      redirect_to post_path(notification.notifiable)
    else
      redirect_to user_path(notification.notifiable.user)
    end
  end

end


