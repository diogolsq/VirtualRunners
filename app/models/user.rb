class User < ApplicationRecord
  validates :name, :username, :password, :level, :email, presence: true
  validates :username, uniqueness: true

  has_many :tracks, through: :races
  has_many :messages, dependent: :destroy
  has_many :races, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 # has_one_attached :photo # Cloudinary

 #  # we will let the geocode access our address and convert it to latitude and longitude. #mapbox
 #  geocoded_by :address
 #  after_validation :geocode, if: :will_save_change_to_address?

end
