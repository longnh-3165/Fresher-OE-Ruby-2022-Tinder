class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_1"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
