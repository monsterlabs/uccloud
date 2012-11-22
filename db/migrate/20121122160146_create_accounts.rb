class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.text :description
      t.string :admin_email
      t.boolean :disabled, default: false

      t.timestamps
    end
  end
end
