class CreateEmailAddresses < ActiveRecord::Migration
  def change
    create_table :email_addresses do |t|
      t.references :user
      t.string :email
      t.boolean :primary

      t.timestamps
    end
    add_index :email_addresses, :user_id
  end
end
