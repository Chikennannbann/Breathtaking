class Post < ApplicationRecord
  has_one_attached :view_image
  belongs_to :end_user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags


  validates :view_image, presence: true
  validates :title, presence: true
  validates :nation, presence: true
  validates :prefecture, presence: true
  validates :place, presence: true

  geocoded_by :place
  after_validation :geocode

  def get_view_image
      view_image
  end

  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end

  def self.looks(word)
    if word
      Post.where('title LIKE? or body LIKE? or nation LIKE? or prefecture LIKE? or place LIKE?',
      "%#{word}%","%#{word}%","%#{word}%", "%#{word}%","%#{word}%")
    else
      Post.all
    end
  end

  def save_tags(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # タグが存在していればタグの名前を配列として取得
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete(Tag.find_by(name: old))
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end
end
