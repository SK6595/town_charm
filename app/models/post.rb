class Post < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  #belonngs_to :userと同義
  #def user
  #  User.find(self.user_id)
  #end
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy


  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      self.image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    #byebug
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
