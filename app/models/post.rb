class Post < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true
  validates :address, presence: true

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  geocoded_by :address
  after_validation :geocode

  scope :active_user, -> { includes(:user).where(user: {is_active: true}) }

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      self.image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    self.image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search_for(content)
    Post.where('title LIKE ?', '%'+content+'%')
  end

  after_create do
    user.followers.each do |user|
    notifications.create(user_id: user.id)
    end
  end

end
