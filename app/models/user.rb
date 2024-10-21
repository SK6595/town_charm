class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  # has_many :posts と同義
  #def posts
  #  Post.where(user_id: self.id)
  #end


  has_one_attached :profile_image

  def get_profile_image(with,height)
   unless profile_image.attached?
     file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
     profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
   profile_image.variant(resize_to_limit: [with, height]).processed
  end
end
