class AddOpenTokSessionIdToSessions < ActiveRecord::Migration
  def change
    change_table :sessions do |t|
      t.string :ot_session_id
    end
  end
end
