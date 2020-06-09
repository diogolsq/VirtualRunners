class MessagesController < ApplicationController

  def create
    @user = current_user
    @message = Message.new(message_params)

    if @message.save
    else
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
