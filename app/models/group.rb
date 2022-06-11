class Group < ApplicationRecord

  has_one_attached :group_image
  has_many :group_end_users
  has_many :end_users, through: :group_end_users

  validates :name, presence: true
  validates :caption, presence: true
  validates :destination, presence: true
  validates :date, presence: true


  def get_group_image
    # jpgにするとデプロイでのエラー回避になる, if文もokだが記述量が多くなるためunlessが無難
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/mt-fuji.jpg')
      group_image.attach(io: File.open(file_path), filename: 'mt-fuji.jpg', content_type: 'image/jpeg')
    end
    group_image
  end

  # オーナーの名前をどこからでも引っ張るためのメソッド
  def owner_name
    self.end_users.find(self.owner_id).name
  end
end
