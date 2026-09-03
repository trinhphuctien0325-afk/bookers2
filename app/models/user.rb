class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
has_many :active_relationships,
         class_name: "Relationship",
         foreign_key: "follower_id",
         dependent: :destroy
 has_many :passive_relationships,
         class_name: "Relationship",
         foreign_key: "followed_id",
         dependent: :destroy
             
has_many :following, through: :active_relationships, source: :followed
has_many :followers, through: :passive_relationships, source: :follower

  has_one_attached :profile_image

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :introduction, length: { maximum: 50 }
  validates :name, uniqueness: true, length: { minimum: 2, maximum: 20 }

  def get_profile_image
    if profile_image.attached?
      profile_image
    else
      "no_image.jpg"
end
end
def self.search(content, method)
  case method
  when "perfect"
    where(name: content)
  when "forward"
    where("name LIKE ?", "#{content}%")
  when "backward"
    where("name LIKE ?", "%#{content}")
  when "partial"
    where("name LIKE ?", "%#{content}%")
  end
end
end
