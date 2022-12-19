class Preference < ApplicationRecord
  HEX = /\A#(?:\h{3}){1,2}\z/
  belongs_to :user
  store_accessor :payload, :theme, :locale
  validates :locale, presence: true, length: { maximum: 2 }
  validates :theme, presence: true, format: HEX
end
