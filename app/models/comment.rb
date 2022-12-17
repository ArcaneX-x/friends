class Comment < ApplicationRecord
  include UserExtensions

  belongs_to :event
  belongs_to :user, optional: true

  validates :body, presence: true
  validates :user_name, presence: true, unless: :user_present?

  # scope :with_user, -> { where.not(user_id: nil) }
  def user_name
    if user.present?
      user.name
    else
      super
    end
  end
end
