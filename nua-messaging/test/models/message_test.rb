# frozen_string_literal: true

require './test/test_helper'

class MessageTest < ActiveSupport::TestCase

  test 'new message has unread status' do
    message = Message.create(body: 'test')

    assert_equal false, message.read
  end

  test 'after create outbox is assigned to sender and inbox to receiver' do
    message = Message.create(body: 'something', inbox: inbox(:second), outbox: outbox(:second))

    assert_equal User.default_doctor.inbox, message.inbox
    assert_equal User.current.outbox, message.outbox
  end

  test 'message cannot be created without body' do
    message = Message.new

    assert message.invalid?
  end
end
