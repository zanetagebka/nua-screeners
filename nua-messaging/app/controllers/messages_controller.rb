class MessagesController < ApplicationController

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
    session[:original_message] = params[:original_message]
  end

  def create
    @original_message = Message.find_by(id: session[:original_message])
    @message = Message.new(message_params)

    ResolveMessageSender.new(@original_message, @message).call

    redirect_to messages_path
  rescue ActiveRecord::RecordInvalid
    redirect_to messages_path, error: 'Message needs to has body!'
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

end
