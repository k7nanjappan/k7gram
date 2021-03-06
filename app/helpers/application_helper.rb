module ApplicationHelper

  @eng = :en
  @jap = :ja

  def avatar_url user
    return user.image if user.image
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "https://en.gravatar.com/avatar/#{gravatar_id}.jpg"
  end

  def change_lang
    eng = :en
    jap = :ja
    if I18n.locale == eng
      params[:locale] = :ja
      I18n.locale = :ja
    elsif I18n.locale == jap
      params[:locale] = :en
      I18n.locale = :en
    end
  end

end
