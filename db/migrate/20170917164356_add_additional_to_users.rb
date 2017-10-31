class AddAdditionalToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :count, :integer
    add_column :users, :email, :string
    add_column :users, :mobile, :string
  end
end
