class AddOmniauthFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :providers, :string
    add_column :users, :uid, :integer
    add_column :users, :name, :string
    add_column :users, :image, :string
  end
end
