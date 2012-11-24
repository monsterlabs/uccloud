class CreateInvitees < ActiveRecord::Migration
  def change
    create_table :invitees do |t|
      t.references :session
      t.boolean :host

      t.timestamps
    end
    add_index :invitees, :session_id
  end
end
