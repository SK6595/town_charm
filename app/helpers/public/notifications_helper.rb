module Public::NotificationsHelper

  def notification_message(notification)
    case notification.notifiable_type
    when "Favorite"
      "#{notification.notifiable.user.name}さんが#{notification.notifiable.post.title}をいいねしました"
    when "Comment"
      "#{notification.notifiable.user.name}さんが#{notification.notifiable.post.title}にコメントしました"
    when "Post"
      "#{notification.notifiable.user.name}さんが新しい投稿をしました"
    else
      ""
    end
  end

end
