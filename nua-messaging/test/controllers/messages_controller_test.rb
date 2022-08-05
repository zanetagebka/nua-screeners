# frozen_string_literal: true

require './test/test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @message = Message.create(body: 'Test', outbox: outbox(:first), inbox: inbox(:first))
  end

  test 'when see the message status of read change to true' do
    assert_equal false, @message.read
    get message_path(@message)

    assert_equal true, @message.reload.read
  end

  test 'when see the message decrease the read number on inbox' do
    original_message = Message.create(body: 'I told you, you are sick!', created_at: Date.today)
    MessageSenderService.new(original_message, @message).call
    assert_equal 1, @message.inbox.reload.unread
    get message_path(@message)

    assert_equal 0, @message.inbox.reload.unread
  end
end
