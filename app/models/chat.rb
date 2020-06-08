class Chat < ApplicationRecord
  belongs_to :track

  has_many :messages, dependent: :destroy
end
