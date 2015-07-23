module UserHelper
  def avatar_url(user, size = nil)
    if user.avatar_url(size)
      user.avatar_url(size)
    else
      image_url("start.png")
    end
  end
end
