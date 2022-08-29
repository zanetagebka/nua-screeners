class MessagesController < ApplicationController
  include Pagy::Backend
  helper Pagy::Frontend

  before_action :find_message, only: :resend_prescription

  def index
    messages = User.default_doctor.inbox.messages
    @pagy, @messages = pagy(messages, items: 10)
  end

  def show
    @message = Message.find(params[:id])
    @message.update!(read: true)
    @message.inbox.decrement!(:unread) unless @message.inbox.unread.zero?
  end

  def new
    @message = Message.new
    session[:original_message] = params[:original_message]
  end

  def create
    @original_message = Message.find_by(id: session[:original_message])
    @message = Message.new(message_params)

    MessageSenderService.new(@original_message, @message).call

    redirect_to messages_path
  rescue ActiveRecord::RecordInvalid
    redirect_to messages_path, error: 'Message needs to has body!'
  end

  def resend_prescription
    user = @message.inbox.user
    LostPrescriptionService.new(user).call

    redirect_to message_path(@message), notice: 'You will receive your prescription soon'

  rescue ArgumentError
    redirect_to message_path(@message), notice: 'We are sorry, but we cannot process your request right now.'
  end

  private

  def find_message
    @message = Message.find_by(params[:id])
  end

  def message_params
    params.require(:message).permit(:body)
  end

end
