class Piece < ActiveRecord::Base
  validates :title, presence: true, length: {minimum: 3, maximum: 24}
  validates :description, length: {maximum: 300}
  validates :image, presence: true
end
