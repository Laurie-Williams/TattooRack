class Piece < ActiveRecord::Base
  # validations
  validates :title, presence: true, length: {minimum: 3, maximum: 128}
  validates :description, length: {maximum: 300}
  validates :image, presence: true

  # scopes
  scope :all_by_created_at, -> {all.order(:created_at).reverse_order}

  attr_accessor :crop_x, :crop_y, :crop_height, :crop_width
  belongs_to :user
  mount_uploader :image, PieceUploader

  # class methods
  def self.prev_piece(offset)
    prev_and_next_piece(offset)[0] if offset.present?
  end

  def self.next_piece(offset)
    prev_and_next_piece(offset)[2] if offset.present?
  end

  # instance methods
  def check_and_set_title
    if title.nil? && image_exists?
      self.title = pretty_file_name(image_file_name)
    end
  end


private

  # class methods
  def self.prev_and_next_piece(offset)
    if offset.to_i == 0 #Only retrieve current and next piece if first in list
      array ||= Piece.all_by_created_at.limit(2)
      array.unshift(nil) #Add nil to beginning of array to account for prev being non existent
    else
      array ||= Piece.all_by_created_at.offset(offset.to_i - 1).limit(3) #get prev, current and next piece in array
    end
    array
  end

  # instance methods
  def image_exists?
    uploader = self.image
    !uploader.blank?
  end

  def image_file_name
    self.image.filename
  end

  def pretty_file_name(file_name)

    # Get text in between last "/" and last "."
    title = file_name.split("/")
    title = title[-1].split(".")
    title.pop

    # Reformat text to use spaces
    title = title.join(" ").split(/[-_]/).join(" ").titleize
  end

end
