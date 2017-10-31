class AddPushIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :push_id, :string
  end
end
