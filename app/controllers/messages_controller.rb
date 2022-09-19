class MessagesController < ApplicationController
  before_action :logged_in_user
  before_action :get_followed_users
  before_action :get_messages, :login_room, only: %i(show)

  def index; end

  def show; end

  def create
    message = current_user.messages.build(message_params)

    if message.save
      partial_sender = "messages/mine"
      partial_receiver = "messages/their"
      ActionCable.server.broadcast "room_channel_1",
                                   html_sender: html(message,
                                                     partial_sender),
                                   html_receiver: html(message,
                                                       partial_receiver),
                                   current_user: current_user.id
    else
      render :show
    end
  end

  private

  def html message, partial
    render_to_string(partial: partial,
                     locals: {message: message})
  end

  def login_room
    prefix_one = current_user.id.to_i
    prefix_two = params[:id].to_i
    if prefix_one > prefix_two
      @room_id = "#{prefix_one}-#{prefix_two}"
    elsif prefix_one < prefix_two
      @room_id = "#{prefix_two}-#{prefix_one}"
    end
  end

  def get_followed_users
    @users = Relationship.get_followed_users(current_user)
                         .includes(followed: :messages)
  end

  def get_messages
    @messages = Message.get_messages(current_user, params[:id])
    @message  = current_user.messages.build
  end

  def message_params
    params.require(:message).permit(:content, :user_receive_id)
  end
end
