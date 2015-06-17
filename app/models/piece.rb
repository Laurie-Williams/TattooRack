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

  # instance methods
  def check_and_set_title
    if title.nil? && image_exists?
      self.title = pretty_file_name(image_file_name)
    end
  end

  private

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
