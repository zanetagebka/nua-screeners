class LostPrescriptionService

  def initialize(user)
    @user = user
  end

  def call
    send_message!
    issue_payment
  end

  private

  def send_message!
    Message.create!(body: "#{@user.full_name} lost their prescription. Payment were issued.")
  end

  def issue_payment
    PaymentProviderFactory.provider.debit_card(@user)
  end

end
