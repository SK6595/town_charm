class Group < ApplicationRecord

  has_one_attached :image
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  belongs_to :owner, class_name: "User"
  validates :name, presence: true
  validates :introduction, presence: true

  def applying_users
    self.users.includes(:group_users).where('group_users.status': :applying)
  end

  def applobed_users
    self.users.includes(:group_users).where('group_users.status': :applobed)
  end

  def rejected_users
    self.users.includes(:group_users).where('group_users.status': :rejected)
  end

  def group_user_by?(user)
    group_users.exists?(user_id: user.id)
  end

  def is_ownered_by?(user)
    self.owner == user
  end

  def get_image(with,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [with, height]).processed
  end

  def self.search_for(content)
    Group.where('name LIKE ?', "%#{content}%")
  end
end
