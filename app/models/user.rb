class User < ApplicationRecord
  FORMAT_USERNAME = /\A\w+\z/
  has_many :events

  validates :email,
            presence: true,
            length: {maximum: 255},
            uniqueness: true,
            format: URI::MailTo::EMAIL_REGEXP
  validates :name,
            presence: true,
            length: {maximum: 35},
            format: {with: FORMAT_USERNAME}
end
