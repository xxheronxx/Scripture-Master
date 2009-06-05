class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.integer :user_id
      t.integer :refered_to_id
      t.integer :refered_from_id
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
