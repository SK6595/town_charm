class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  scope :active_users, -> { where(is_active: true) }
  scope :deleted_users, -> { where(is_active: false) }

  validates :name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #validates :name, presence: true
  #validates :email, presence: true


  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :group_users, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms
  # has_many :posts と同義
  #def posts
  #  Post.where(user_id: self.id)
  #end

  has_one_attached :profile_image

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

  def get_profile_image(with,height)
   unless profile_image.attached?
     file_path = Rails.root.join('app/assets/images/no_image.jpg')
     profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
   profile_image.variant(resize_to_limit: [with, height]).processed
  end

  def self.search_for(content)
    User.where('name LIKE ?', "%#{content}%")
  end

  def join_group(group)
    self.group_users.find_or_create_by(group: group)
  end

  def leave_group(group)
    self.group_users.find_by(group: group)&.destroy
  end

  def active_for_authentication?
    super && is_active?
  end

  def inactive_message
    is_active ? super : :is_active
  end

end
