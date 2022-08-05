class MessageSender

  def initialize(original_message, message)
    @original_message = original_message
    @message = message
  end

  def call
    prepare_message!
    increase_unread_doctor_msg
  end

  private

  def older_than_week?
    return true if @original_message.created_at.before?(7.days.ago)

    false
  end

  def send_to
    @message.inbox = if older_than_week?
                       User.default_admin.inbox
                     else
                       User.default_doctor.inbox
                     end
  end

  def prepare_message!
    @message.inbox = send_to
    @message.outbox = User.current.outbox
    @message.save!
  end

  def increase_unread_doctor_msg
    return if older_than_week?

    User.default_doctor.inbox.increment!(:unread)
  end
end
