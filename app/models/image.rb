class Image < ApplicationRecord
  has_one_attached :image
  validates_uniqueness_of :title
  belongs_to :user
  has_many :tag_relations
  has_many :tags, through: :tag_relations
end
