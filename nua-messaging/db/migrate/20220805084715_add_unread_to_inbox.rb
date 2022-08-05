class AddUnreadToInbox < ActiveRecord::Migration[6.1]
  def change
    add_column :inboxes, :unread, :integer
  end
end
