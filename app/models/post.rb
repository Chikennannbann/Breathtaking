class Post < ApplicationRecord
  has_one_attached :view_image
  belongs_to :end_user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :view_image, presence: true
  validates :title, presence: true
  validates :nation, presence: true
  validates :prefecture, presence: true
  validates :place, presence: true

  def get_view_image
      view_image
  end

  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end
end
