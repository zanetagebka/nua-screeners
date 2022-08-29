# frozen_string_literal: true

require '../test_helper'

class ProviderTest < ActiveSupport::TestCase

  test '#debit_card raise error when no cardholder provided' do
    assert_raises(ArgumentError, 'Card owner is required') { PaymentProviderFactory.provider.debit_card(nil) }
  end
end
