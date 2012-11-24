class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :account
      t.string :user_email
      t.string :user_access_code
      t.boolean :custom_access_code, default: false
      t.string :display_name
      t.string :time_zone, default: "America/Los_Angeles"
      t.boolean :host_privileges, default: false

      t.timestamps
    end
    add_index :users, :account_id
  end
end
