class Feedback < ApplicationRecord
  validates :username, :email, presence: true
  validates :email, email: true
  validates :message, length: { maximum: 1200 }
end
