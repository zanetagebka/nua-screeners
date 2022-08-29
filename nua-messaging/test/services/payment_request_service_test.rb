# frozen_string_literal: true

require '../test_helper'

class PaymentRequestServiceTest < ActiveSupport::TestCase
  test 'create new payment instance' do
    user = User.patient.first
    service = PaymentRequestService.new(user)

    assert_difference('Payment.count', 1) do
      service.call
    end
    assert_equal Payment.last.user, user
  end
end
