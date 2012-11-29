class AddColumnsToSessionAndInvitees < ActiveRecord::Migration
  def change
    add_column :sessions, :subject, :string
    add_column :invitees, :user_id, :integer
  end
end
