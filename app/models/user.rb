class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
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
end