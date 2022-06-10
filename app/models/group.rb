class Group < ApplicationRecord

  has_one_attached :group_image
  has_many :group_end_users
  has_many :end_users, through: :group_end_users

  validates :name, presence: true
  validates :caption, presence: true
  validates :destination, presence: true
  validates :date, presence: true


  def get_group_image
    if group_image.attached?
      group_image
    else
      file_path = Rails.root.join('app/assets/images/mt-fuji.jpeg')
      group_image.attach(io: File.open(file_path), filename: 'mt-fuji.jpeg', content_type: 'image/jpeg')
    end
  end

end
