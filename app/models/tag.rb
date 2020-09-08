class Tag < ApplicationRecord
  has_many :tag_relations
  has_many :images, through: :tag_relations
end
