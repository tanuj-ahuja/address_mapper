class RenamePushIdToPuiInUsers < ActiveRecord::Migration[5.0]
  def change
  	def up
    rename_column :cats, :push_id, :pui
  end

  def down
    rename_column :cats, :pui, :push_id
  end
  end
end
