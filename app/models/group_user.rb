class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group
  
  validates :user_id, uniqueness: {scope: :group_id}
  
  enum status: { applying: 0, applobed: 1, rejected: 2 }
end
