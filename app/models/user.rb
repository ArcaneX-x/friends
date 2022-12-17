class User < ApplicationRecord
  EMAIL_ADDRESS = /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_one :setting, dependent: :destroy

  before_validation :set_name, on: :create

  validates :name, presence: true, length: { maximum: 35 }

  validates :email,
            length: { maximum: 255 },
            uniqueness: true,
            format: EMAIL_ADDRESS

  after_commit :link_subscriptions, on: :create

  private

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end

  def set_name
    self.name = "Anonymous №#{rand(777)}" if self.name.blank?
  end
end
