module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}", role: "alert") do
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "bi bi-trash-#{icon_class}"
  end

  def user_avatar(user)
    asset_path('avatar.png')
  end

  def user_avatar_thumb(user)

      asset_path('avatar-thumb.png')

  end

  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.url
    else
      asset_path('event.jpg')
    end
  end

  def is_author?(event)
    return false unless current_user
    event.user_id == current_user.id
  end

  def subscribed?
    return false unless current_user
    Subscription.exists?(user_id: current_user.id)
  end

  def trash(photo)
    if current_user_can_edit?(photo)
      link_to(
        fa_icon('trash'), event_photo_path(photo.event, photo),
        method: :delete, data: { confirm: t('app.messages.exactly_remove?') }
      )
    end
  end
end
