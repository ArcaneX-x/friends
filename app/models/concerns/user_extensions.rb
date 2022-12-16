module UserExtensions
  # include ActiveSupport::Concurrent
  #
  # included do
  #   # validates .....
  # end

  private

  def user_present?
    user.present?
  end
end

