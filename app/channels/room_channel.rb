class RoomChannel < ApplicationCable::Channel
  def subscribed
    return if @room_id

    stream_from "room_channel_#{@room_id}"
  end

  def unsubscribed; end
end
