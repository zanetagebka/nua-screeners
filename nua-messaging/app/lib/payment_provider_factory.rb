class PaymentProviderFactory
  def self.provider
    @provider ||= Provider.new
  end
end
