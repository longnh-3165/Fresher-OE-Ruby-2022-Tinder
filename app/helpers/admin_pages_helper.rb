module AdminPagesHelper
  def actived_icon user
    user.actived? ? "fa-check" : "fa-xmark"
  end

  def admin_icon user
    user.admin? ? "fa-check" : "fa-xmark"
  end

  def type_of_btn user
    user.gold? ? "btn-outline-danger" : "btn-outline-warning"
  end

  def act user
    user.gold? ? t(".down") : t(".up")
  end

  def disabled_btn user
    !user.actived? ? "disabled" : ""
  end
end
