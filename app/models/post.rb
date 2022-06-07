class Post < ApplicationRecord
  has_one_attached :view_image
  belongs_to :end_user

  validates :view_image, presence: true
  validates :title, presence: true
  validates :nation, presence: true
  validates :prefecture, presence: true
  validates :place, presence: true

  def get_view_image
      view_image
  end
end
