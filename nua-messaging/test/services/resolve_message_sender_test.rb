# frozen_string_literal: true

require '/Users/zanetagebka/development/webdoctor/interview-screeners/nua-messaging/test/test_helper'

class ResolveMessageSenderTest < ActiveSupport::TestCase

  test 'assign inbox to admin if original message is older than 7 days' do
    original_message = Message.create(body: 'You are sick.', created_at: 2.weeks.ago)
    message = Message.new(body: 'No, Im not!')

    ResolveMessageSender.new(original_message, message).call

    assert_equal message.inbox, User.default_admin.inbox
  end

  test 'assign to doctor if original message is no older than 7 days' do
    original_message = Message.create(body: 'I told you, you are sick!')
    message = Message.new(body: 'I do not listen doctors, I prefer magic')

    ResolveMessageSender.new(original_message, message).call

    assert_equal message.inbox, User.default_doctor.inbox
  end
end
