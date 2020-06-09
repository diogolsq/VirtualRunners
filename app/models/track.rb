class Track < ApplicationRecord
  validates :name, :description, :level, :start_address, :end_address, :time_to_complete, presence: true

  has_many :races, dependent: :destroy
  has_many :users, through: :races
  has_many :chats, dependent: :destroy

  has_one_attached :photo # Cloudinary

  geocoded_by :start_address, latitude: :start_latitude, longitude: :start_longitude
  after_validation :geocode, if: :start_address_changed?

  geocoded_by :end_address, latitude: :end_latitude, longitude: :end_longitude
  after_validation :geocode, if: :end_address_changed?
end
