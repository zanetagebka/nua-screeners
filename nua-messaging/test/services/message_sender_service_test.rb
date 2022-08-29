# frozen_string_literal: true

require './test/test_helper'

class MessageSenderServiceTest < ActiveSupport::TestCase

  test 'assign inbox to admin if original message is older than 7 days' do
    original_message = Message.create(body: 'You are sick.', created_at: 2.weeks.ago, inbox: inbox(:first),
                                      outbox: outbox(:first))
    message = Message.new(body: 'No, Im not!')

    MessageSenderService.new(original_message, message).call

    assert_equal message.reload.inbox, User.default_admin.inbox
  end

  test 'assign to doctor if original message is no older than 7 days' do
    original_message = Message.create(body: 'I told you, you are sick!', created_at: Date.today)
    message = Message.new(body: 'I do not listen doctors, I prefer magic')

    MessageSenderService.new(original_message, message).call

    assert_equal User.default_doctor.inbox, message.reload.inbox
  end

  test 'it increase number of unread message in inbox' do
    original_message = Message.create(body: 'I told you, you are sick!', created_at: Date.today)
    message = Message.new(body: 'I do not listen doctors, I prefer magic')

    MessageSenderService.new(original_message, message).call

    assert_equal User.default_doctor.inbox, message.reload.inbox

    assert_equal 1, message.reload.inbox.unread
  end
end
