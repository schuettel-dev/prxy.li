class LinkDecorator < SimpleDelegator
  include ActionView::Helpers::DateHelper

  def display_expires_at
    return I18n.t("link.expires_never") if expires_never?

    I18n.t("link.expires_in", distance: distance_of_time_in_words(Time.zone.now, expires_at))
  end
end
