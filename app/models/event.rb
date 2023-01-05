class Event < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user
  has_many :photos

  validates :title, presence: true, length: { maximum: 255 }
  validates :address, :datetime, presence: true
end
