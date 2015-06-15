class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :username,  presence: true,
                        length: {minimum: 5, maximum: 14},
                        uniqueness: true
  validates :name,  presence: true,
                    length: {minimum: 2, maximum: 24}

  has_many :pieces

  mount_uploader :avatar, AvatarUploader

end
