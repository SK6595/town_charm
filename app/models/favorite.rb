class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :post
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: {scope: :post_id}

  after_create do
    notifications.create(user_id: post.user_id)
  end
end
