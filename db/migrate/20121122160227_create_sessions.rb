class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :account
      t.integer :host_id
      t.boolean :scheduled_session, default: true
      t.datetime :start_datetime
      t.datetime :end_datetime

      t.timestamps
    end
    add_index :sessions, :account_id
  end
end
