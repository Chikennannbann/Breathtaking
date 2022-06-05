class Post < ApplicationRecord
  has_one_attached :view_image
  belongs_to :end_user

  validates :view_image, presence: true
  validates :title, presence: true
  validates :nation, presence: true
  validates :prefecture, presence: true
  validates :place, presence: true

  def get_view_image
    if view_image.attached?
      view_image
    else
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
  end
end
