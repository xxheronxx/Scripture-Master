class AddUserIdToScriptures < ActiveRecord::Migration
  def self.up
    add_column :scriptures, :user_id, :integer
  end

  def self.down
    remove_column :scriptures, :user_id
  end
end
