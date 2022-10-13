module ApplicationHelper
  include Pagy::Frontend

  def full_title page_title
    base_title = t "base_title"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def dob age
    Time.now.utc.to_date.years_ago(age)
  end

  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = "success" if type == "notice"
      type = "error"   if type == "alert"
      text = "toastr.#{type}('#{message}');"
      flash_messages << text if message
    end
    flash_messages.join("\n")
  end

  def show_errors object, field_name
    if object.errors.any? && object.errors.messages[field_name].present?
      object.errors.messages[field_name].join(", ")
    end
  end
end
