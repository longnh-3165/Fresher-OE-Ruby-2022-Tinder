class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform notification, count
    ActionCable.server.broadcast "notifications_channel",
                                 {notification: notification,
                                  count: count}
  end
end
