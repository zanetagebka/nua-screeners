class Message < ApplicationRecord

  belongs_to :inbox
  belongs_to :outbox

  validates_presence_of :body

end