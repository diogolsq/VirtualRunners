class Track < ApplicationRecord
  validates :username, :password, :level, :email, presence: true
  validates :username, uniqueness: true

  has_many :chats, dependent: :destroy
  has_many :races, dependent: :destroy

end
