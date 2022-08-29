# frozen_string_literal: true

require '../test_helper'

class LostPrescriptionServiceTest < ActiveSupport::TestCase
  test 'sends message to admin with information' do
    user = User.patient.first
    admin = User.default_admin
    service = LostPrescriptionService.new(user)

    assert_difference('Message.count', 1) do
      service.call
    end
    assert_equal "#{user.full_name} lost their prescription. Payment were issued.", Message.last.body
    assert_equal admin.inbox, Message.last.inbox
  end
end
