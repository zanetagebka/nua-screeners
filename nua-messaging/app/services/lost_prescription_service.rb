class LostPrescriptionService

  def initialize(user)
    @user = user
  end

  def call
    issue_payment
    inform_admin!
  end

  private

  def inform_admin!
    message = prepare_message!
    message.inbox = User.default_admin.inbox
    message.save!
  end

  def prepare_message!
    Message.create!(body: "#{@user.full_name} lost their prescription. Payment were issued.")
  end

  def issue_payment
    PaymentRequestService.new(@user).call
  end
end
