class Message < ApplicationRecord
  validates :content, presence: true, length: { maximum: 240 }

  belongs_to :chat
  belongs_to :user
end
