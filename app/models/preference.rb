class Preference < ApplicationRecord
  HEX = /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/
  belongs_to :user
  store_accessor :payload, :theme, :locale
  validates :locale, presence: true, length: { is: 2 }
  validates :theme, presence: true, format: HEX
end
