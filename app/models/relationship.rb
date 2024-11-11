class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  def self.following?(current_user, target_user)
    self.find_by(follower_id: current_user.id, followed_id: target_user)
  end
end
