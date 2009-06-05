require File.dirname(__FILE__) + '/../../spec_helper'

describe "/scriptures/new.html.erb" do
  include ScripturesHelper
  
  before(:each) do
    @scripture = mock_model(Scripture)
    @scripture.stub!(:new_record?).and_return(true)
    @scripture.stub!(:reference).and_return("MyString")
    @scripture.stub!(:url).and_return("MyString")
    @scripture.stub!(:text).and_return("MyText")
    assigns[:scripture] = @scripture
  end

  it "should render new form" do
    render "/scriptures/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", scriptures_path) do
      with_tag("input#scripture_reference[name=?]", "scripture[reference]")
      with_tag("input#scripture_url[name=?]", "scripture[url]")
      with_tag("textarea#scripture_text[name=?]", "scripture[text]")
    end
  end
end


