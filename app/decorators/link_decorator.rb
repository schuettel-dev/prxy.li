class LinkDecorator < SimpleDelegator
  def full_short_link_url
    "https://forward.schuettel.dev/#{token}"
  end
end
