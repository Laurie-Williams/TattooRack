class User < ActiveRecord::Base
  # validations
  validates :username,  presence: true, length: {minimum: 5, maximum: 14}, uniqueness: true
  validates :name,      presence: true, length: {minimum: 2, maximum: 24}

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable

  # associations
  has_many :pieces, -> {order(position: :asc)} #Order User.pieces by position
  has_many :comments
  acts_as_voter
  mount_uploader :avatar, AvatarUploader

end
