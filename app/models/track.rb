class Track < ApplicationRecord
  validates :name, :description, :level, :start_address, :end_address, :time_to_complete, presence: true

  has_many :races, dependent: :destroy
  has_many :users, through: :races
  has_many :chats, dependent: :destroy

  has_one_attached :photo # Cloudinary

  # geocoded_by :start_address, latitude: :start_latitude, longitude: :start_longitude

  # geocoded_by :end_address, latitude: :end_latitude, longitude: :end_longitude
  # after_validation :geocode, if: :any_address_changed?

  # def any_address_changed?
  #   start_address_changed? || end_address_changed?
  # end

  before_save :geocode_endpoints

  private

  #To enable Geocoder to works with multiple locations
  def geocode_endpoints
    if start_address_changed?
      geocoded = Geocoder.search(start_address).first
      if geocoded
        self.start_latitude = geocoded.latitude
        self.start_longitude = geocoded.longitude
      end
    end
    # Repeat for destination
    if end_address_changed?
      geocoded = Geocoder.search(end_address).first
      if geocoded
        self.end_latitude = geocoded.latitude
        self.end_longitude = geocoded.longitude
      end
    end
  end
end
