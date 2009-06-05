require File.dirname(__FILE__) + '/../spec_helper'

describe Scripture do
  fixtures :scriptures
  
  before(:each) do
    @scripture = Scripture.new(valid_scripture_hash) # grabs the hash below
  end

  it "should be valid" do
    @scripture.should be_valid
  end
  
  it "should not be valid without a reference book" do
    @scripture.book = nil
    @scripture.should_not be_valid
  end
  
  it "should not be valid without text" do
    @scripture.text = nil
    @scripture.should_not be_valid
  end
  
  it "should not be valid without a user_id" 
  
  it "should recognize references to standard works" do
    @scripture.should be_standard_work(@scripture)
  end
  
  it "should not be a standard work without numeric chapters" do
    @scripture.chapter = "three"
    @scripture.should_not be_standard_work(@scripture)
  end
  
  it "should not be a standard work without numeric verses" do
    @scripture.verse = "seven"
    @scripture.should_not be_standard_work(@scripture)
  end
  
  it "should recognize references to non standard works books" do
    @scripture.book = "Sandy Pandy, Fine and Dandy"
    @scripture.should_not be_standard_work(@scripture)
  end
  
  it "should autogenerate url to scriptures.lds.org for standard works references"
  
  it "should automatically pull content for standard warks references"
  
  def valid_scripture_hash
    { :book => '1 Nephi', :chapter => '3', :verse => '7',
      :text => "We'll fake it for now"}
  end
end
