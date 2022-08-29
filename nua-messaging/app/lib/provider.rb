class Provider
  def debit_card(user)
    raise ArgumentError, 'Card owner is required' if user.nil?
  end
end
