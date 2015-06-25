class Piece < ActiveRecord::Base
  # validations
  validates :title, presence: true, length: {maximum: 128}
  validates :description, length: {maximum: 300}
  validates :image, presence: true

  # scopes
  scope :published, -> {where(published: true)}
  scope :all_by_created_at, -> {all.order(:created_at).reverse_order.published}
  scope :all_in_category, ->(category, sort_by = nil) do
    relation = all.published
    relation.where!(category_id: Category.get_id_from_name(category)) if category
    relation.order!(:cached_votes_up) if sort_by == nil
    relation.order!(:comments_count) if sort_by == "comments"
    relation.order!(:created_at).reverse_order
  end

  # attributes
  attr_accessor :crop_x, :crop_y, :crop_height, :crop_width, :offset, :list

  # associations
  belongs_to :user
  belongs_to :category
  acts_as_commentable
  acts_as_votable
  acts_as_list scope: :user #Increment Piece.position for each new Piece by user
  mount_uploader :image, PieceUploader


  # instance methods
  def prev_list_piece
    list_prev_and_next[0] if offset.present?
  end

  def next_list_piece
    list_prev_and_next[2] if offset.present?
  end

  def prev_user_piece
    user_prev_and_next[0]
  end

  def next_user_piece
    user_prev_and_next[2]
  end

  def check_and_set_title
    if title.nil? && image_exists?
      self.title = pretty_file_name(image_file_name)
    end
  end


private

  # instance methods
   def list_prev_and_next
    if offset.to_i == 0 #Only retrieve current and next piece if first in list
      #Add nil to beginning of array to account for prev being non existent
      @list_piece_array ||= Piece.all_in_category(self.list).limit(2).unshift(nil)
    else
      @list_piece_array ||= Piece.all_in_category(self.list).offset(offset.to_i - 1).limit(3) #get prev, current and next piece in array
    end
  end

  def user_prev_and_next
    if self.last?
      @user_piece_array ||= Piece.published.where(user_id: user_id).reverse_order.limit(2).unshift(nil)
    else
      @user_piece_array ||= Piece.published.where(user_id: user_id).offset(self.position - 2).limit(3).reverse #get prev, current and next piece in array
    end
  end

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
