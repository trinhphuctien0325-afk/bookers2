class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title, presence: true
validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  def self.search(content, method)
  case method
  when "perfect"
    where(title: content)
  when "forward"
    where("title LIKE ?", "#{content}%")
  when "backward"
    where("title LIKE ?", "%#{content}")
  when "partial"
    where("title LIKE ?", "%#{content}%")
  end
end
end
