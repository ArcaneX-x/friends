module ApplicationHelper
  def fa_icon(icon_class)
    content_tag 'span', '', class: "bi bi-trash-#{icon_class}"
  end

  def user_avatar(user)
    asset_path('avatar.png')
  end

  def user_avatar_thumb(user)
    asset_path('avatar-thumb.png')
  end
end
