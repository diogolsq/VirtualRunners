class User < ApplicationRecord
  validates :name, presence: true
  # validates :username, uniqueness: true


  has_many :races, dependent: :destroy
  has_many :tracks, through: :races
  has_many :messages, dependent: :destroy




  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:strava]

 # has_one_attached :photo # Cloudinary

 #  # we will let the geocode access our address and convert it to latitude and longitude. #mapbox
 #  geocoded_by :address
 #  after_validation :geocode, if: :will_save_change_to_address?

  def self.find_for_strava_oauth(auth)
    # 1) assign correct values to the keys that are missing in user info hash
    # 2) find in the documentation of strava what is the scope that allows us to do everything, full permission, all info
    # 3) kill the server after changing the devise rb file
    # 4) open server and log in again, chacking what is now inside the auth variable
    user_info = {
      uid: auth["uid"],
      provider: auth["provider"],
      token: auth["credentials"]["token"],
      name: auth["info"]["name"],
      refresh_token: auth["credentials"]["refresh_token"] ,
      token_expiry: auth["credentials"]["exipires_at"],
      profile_img_url: auth["extra"]["raw_info"]["profile"]
    }

    user = User.find_by(provider: user_info[:provider], uid: user_info[:uid])
    if user
      user.update(user_info)
    else
      user = User.new(user_info)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save(validate: false)
    end

    return user
  end

end
