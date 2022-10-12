# app/mailers/user_mailer.rb
class UserMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: "users/mailer"

  def reset_password_instructions record, _token, _opt = {}
    @user = record
    create_reset_password_token(@user)
    mail to: @user.email, subject: t(".subject"),
         from: "noreply@example.com"
  end

  private
  def create_reset_password_token user
    raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
    @token = raw
    user.reset_password_token = hashed
    user.reset_password_sent_at = Time.now.utc
    user.save
  end
end
