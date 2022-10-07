class AdminMailer < ApplicationMailer
  def suggestion_email_month user
    @user = user
    mail to: @user.email, subject: t("proposal_letter")
  end
end
