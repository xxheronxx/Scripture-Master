require File.dirname(__FILE__) + '/../../spec_helper'

describe "/scriptures/show.html.erb" do
  include ScripturesHelper
  
  before(:each) do
    @scripture = mock_model(Scripture)
    @scripture.stub!(:reference).and_return("MyString")
    @scripture.stub!(:url).and_return("MyString")
    @scripture.stub!(:text).and_return("MyText")

    assigns[:scripture] = @scripture
  end

  it "should render attributes in <p>" do
    render "/scriptures/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

