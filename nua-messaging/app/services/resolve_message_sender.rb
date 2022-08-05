class ResolveMessageSender

  def initialize(original_message, message)
    @original_message = original_message
    @message = message
  end

  def call
    prepare_message
  end

  private

  def older_than_week?
    return true if @original_message.created_at > 7.days

    false
  end

  def send_to
    @message.inbox = if older_than_week?
                       User.default_admin.inbox
                     else
                       User.default_doctor.inbox
                     end
  end

  def prepare_message
    @message.inbox = send_to
    @message.outbox = User.current.outbox
    @message.save!
  end
end
