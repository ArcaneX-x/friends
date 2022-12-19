class Subscription < ApplicationRecord
  EMAIL_ADDRESS = /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
  include UserExtensions

  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true
  validates :user_name, presence: true, unless: :user_present?
  validates :user_email, format: EMAIL_ADDRESS, unless: :user_present?
  validate :user_owner, if: :user_present?

  # для данного event_id один юзер может подписаться только один раз (если юзер задан)
  validates :user, uniqueness: {scope: :event_id}, if: :user_present?
  # для данного event_id один email может использоваться только один раз (если нет юзера, анонимная подписка)
  validates :user_email, uniqueness: {scope: :event_id}, unless: :user_present?

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def user_owner
    if user_id == event.user_id
      errors.add(user_name, 'You are owner')
    end
  end
end
