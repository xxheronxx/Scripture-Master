class CreateScriptures < ActiveRecord::Migration
  def self.up
    create_table :scriptures do |t|
      t.string :reference
      t.string :url
      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :scriptures
  end
end
