module AdminPagesHelper
  def actived_icon user
    user.actived? ? "fa-check" : "fa-xmark"
  end

  def admin_icon user
    user.admin? ? "fa-check" : "fa-xmark"
  end
end
