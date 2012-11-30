class AddMessageBodyToSession < ActiveRecord::Migration
  def change
    add_column :sessions, :message_body, :text
  end
end
