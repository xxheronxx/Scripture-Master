class ChangeReferencToSourceFields < ActiveRecord::Migration
  def self.up
    rename_column :scriptures, :reference, :book
    add_column :scriptures, :chapter, :string
    add_column :scriptures, :verse, :string
  end

  def self.down
    rename_column :scriptures, :book, :reference
    remove_column :scriptures, :chapter
    remove_column :scriptures, :verse
  end
end
