class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # タグ
  has_many :book_tag_relations, dependent: :destroy
  has_many :tags,through: :book_tag_relations, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  # 一覧の並び替え機能
  scope :latest, -> {order(created_at: :desc)}
  scope :rate_count, -> {order(rate: :desc)}
  scope :favorites_count, -> {order(favorites: :desc)}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%'+content)
    else
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end
end

