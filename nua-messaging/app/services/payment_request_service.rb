class PaymentRequestService

  def initialize(user)
    @user = user
  end

  def call
    user_debit_card
    create_payment
  end

  private

  def create_payment
    Payment.create(user: @user)
  end

  def user_debit_card
    PaymentProviderFactory.provider.debit_card(@user)
  end
end
