module UsersHelper
  def cities
    Country.pluck(:name, :id)
  end

  def gravatar_for user, options = {size: Settings.image.size}
    size = options[:size]
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar rounded-circle")
  end
end
