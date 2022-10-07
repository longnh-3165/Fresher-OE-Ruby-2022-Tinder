class MonthlyWorker
  include Sidekiq::Worker

  MAIL_MONTH = 1

  def perform action
    return unless action == MAIL_MONTH

    User.basic.each do |user|
      AdminMailer.suggestion_email_month(user).deliver_now
    end
  end
end
