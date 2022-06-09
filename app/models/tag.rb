class Tag < ApplicationRecord
  has_many :posts, through: :post_tags
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'

  validates :name, uniqueness: true, presence: true


end
