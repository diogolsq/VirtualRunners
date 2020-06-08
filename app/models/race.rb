class Race < ApplicationRecord
  belongs_to :user
  belongs_to :track
  validates :km_ran, :time_ran, presence: true
end
