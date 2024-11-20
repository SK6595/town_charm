class Group < ApplicationRecord

  has_one_attached :image
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  belongs_to :owner, class_name: "User"

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

  def self.search_for(content)
    Group.where('name LIKE ?', '%'+content+'%')
  end
end
